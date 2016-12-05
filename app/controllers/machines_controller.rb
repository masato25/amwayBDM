require 'ostruct'

class MachinesController < ApplicationController
  before_action :check_session
  def index
    @machines = Machine.order(:id)
    @plains = Plain.select("id, name").map{|p| [p.name, p.id]}
    @plains.push(["无方案", 0])
    p @plains
  end

  def update
    @machine = Machine.find(params[:id])
    if @machine.update({plain_id: params[:plain_id]})
      flash[:notice] = "更新成功"
    else
      flash[:error] = @machine.errors
    end
    redirect_to action: "index"
  end

  #pending
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
            xml.Series do
              series_ids = seriesMap[brand_id].uniq
              series_ids.each do |series_id|
                xml.SeriesID "NL#{series_id.to_s.rjust(7, "0")}"
                a_series = findSeriesById(series_id)
                xml.SeriesName a_series["SeriesName"]
                xml.TitleColor a_series["TitleColor"]
                details = detailMap[series_id]
                details.each{|d|
                  xml.Detail do
                    xml.DetailID d["id"]
                    xml.IsShow d["IsShow"]
                    plain_detail = findPlainByDetailPlainIds(d["id"], palin_id)
                    xml.IdentityId plain_detail["id"]
                    xml.ScreenIndex plain_detail["ScreenIndex"]
                    xml.TouchRect plain_detail["TouchRect"]
                    xml.DetailName d["DetailName"]
                    xml.Feature d["Feature"]
                    xml.DetailImagePaths do
                      d.detail_images.each do |dimg|
                        xml.DetailImagePath dimg
                      end
                    end
                    xml.HealthyFeature d["HealthyFeature"]
                    xml.FeatureImagePath d.feature_images
                    xml.CompositionImagePath d.composition_images
                    xml.HealthyTip d["HealthyTip"]
                    xml.Class do
                      d.p_metadata.each do |pmt|
                        xml.Metadata do
                          xml.SN pmt["SN"]
                          xml.Volume pmt["Volume"]
                          xml.Price pmt["Price"]
                          xml.Color pmt["Color"]
                          xml.QrImagePath pmt.qr_image
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
    PlainDetail.where("plain_id = #{plain_id} and detail_id = #{detail_id}").first
  end

end
