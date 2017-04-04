require 'ostruct'

class MachinesController < ApplicationController
  before_action :check_session
  def index
    @machines = Machine.order(:id)
    @plains = Plain.select("id, name").map{|p| [p.name, p.id]}
    @v_plains = VideoPlain.select("id, name").map{|p| [p.name, p.id]}
    @plains.push(["无方案", 0])
    @v_plains.push(["无方案", 0])
  end

  def update
    @machine = Machine.find(params[:id])
    if @machine.update({plain_id: params[:plain_id], video_plain_id: params[:video_plain_id]})
      flash[:notice] = "更新成功"
    else
      flash[:error] = @machine.errors
    end
    redirect_to action: "index"
  end

  def sync_plain_to_machine
    plain_id = Machine.find(params[:id])["plain_id"]
    myplain = PlainDetail.where("plain_id = #{plain_id}").select("detail_id").map{|o| o.detail_id}
    details = Detail.where("id in (#{myplain.join(",")})").includes(:series)
    brandMap = details.group_by{|d| d.series["brand_id"] }
    seriesMap = {}
    brandMap.map{|k,v|
      v.each{|se|
        if seriesMap[k] == nil
          seriesMap[k] = [se["series_id"]]
        else
          seriesMap[k] = seriesMap[k].push(se["series_id"])
        end
      }
    }
    detailMap = details.group_by{|d| d["series_id"] }
    bxml = buildXML(brandMap, seriesMap, detailMap, plain_id)
    render :xml => bxml.to_xml
  end

  def sync_vidoe_plain_to_machine
    video_plain_id = Machine.find(params[:id])["video_plain_id"]
    videos1 = Video.where("video_plain_id = #{video_plain_id} and screen = 1")
    videos2 = Video.where("video_plain_id = #{video_plain_id} and screen = 2")
    videos3 = Video.where("video_plain_id = #{video_plain_id} and screen = 3")
    bxml = buildVideoXML(video_plain_id, videos1, videos2, videos3)
    render :xml => bxml.to_xml
  end

  #pending
  def set_up_touch_screen
  end

  private
  def buildXML(brandMap, seriesMap, detailMap, palin_id)
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.Product do
        brandMap.keys.each do |brand_id|
          xml.Brand do
            xml.BrandID "BD#{brand_id.to_s.rjust(7, "0")}"
            xml.BrandName findBrandNameById(brand_id)
            series_ids = seriesMap[brand_id].uniq
            series_ids.each do |series_id|
              xml.Series do
                xml.SeriesID "NL#{series_id.to_s.rjust(7, "0")}"
                a_series = findSeriesById(series_id)
                xml.SeriesName a_series["SeriesName"]
                xml.TitleColor a_series["TitleColor"]
                xml.AreaColor a_series["AreaColor"]
                xml.SeriesBackgroundImagePath a_series.series_background_image
                details = detailMap[series_id]
                details.each{|d|
                  plain_details = findPlainByDetailPlainIds(d["id"], palin_id)
                  plain_details.each do |plain_detail|
                    xml.Detail do
                      xml.DetailID d["id"]
                      xml.IsShow d["IsShow"]
                      xml.IdentityId plain_detail["id"]
                      xml.ScreenIndex plain_detail["ScreenIndex"]
                      xml.TouchRect plain_detail["TouchRect"]
                      xml.DetailName d["DetailName"]
                      xml.Feature d["Feature"]
                      xml.ProductPtNumber d["ProductPtNumber"]
                      xml.PolarExprOnly d["PolarExprOnly"]
                      xml.DetailImagePaths do
                        d.detail_images.each do |dimg|
                          xml.DetailImagePath dimg
                        end
                      end
                      xml.HealthyFeature d["HealthyFeature"]
                      xml.FeatureImagePath d.feature_images
                      xml.OtherImagePaths do
                        d.composition_images.each do |dimg|
                          xml.OtherImagePath dimg
                        end
                      end
                      xml.QRCodeImagePath d.qr_image
                      xml.ContentImagePath d.content_image
                      xml.HealthyTip d["HealthyTip"]
                      xml.Class do
                        xml.SNColor d["SNColor"]
                        d.p_metadata.each do |pmt|
                          xml.Metadata do
                            xml.SN pmt["SN"]
                            xml.Volume pmt["Volume"]
                            xml.Price pmt["Price"]
                            xml.Color pmt["Color"]
                            # xml.QrImagePath pmt.qr_image
                          end
                        end
                      end
                    end
                  end
               }
             end
           end
          end
        end
      end
    end
  end

  def buildVideoXML(video_plain_id, videos1, videos2, videos3)
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.VideoPlain do
        xml.VideoPlainId video_plain_id
        xml.Screen1 do
          @a1 = Vp2VdMap.where("screen = 1 AND video_plain_id = #{video_plain_id}")
          @a1.each do |v|
            xml.VideoPath v.video.media.url
          end
        end
        xml.Screen2 do
          @a2 = Vp2VdMap.where("screen = 2 AND video_plain_id = #{video_plain_id}")
          @a2.each do |v|
            xml.VideoPath v.video.media.url
          end
        end
        xml.Screen3 do
          @a3 = Vp2VdMap.where("screen = 3 AND video_plain_id = #{video_plain_id}")
          @a3.each do |v|
            xml.VideoPath v.video.media.url
          end
        end
      end
    end
  end

  def findBrandNameById(id)
    Brand.find(id)["BrandName"]
  end

  def findSeriesById(id)
    Series.find(id)
  end

  def findSeriesKeyByBrandId(seriesMap, id)
    seriesMap.filter()
  end

  def findPlainByDetailPlainIds(detail_id, plain_id)
    PlainDetail.where("plain_id = #{plain_id} and detail_id = #{detail_id}")
  end

end
