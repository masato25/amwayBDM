var $ = require('jquery')
var Vue = require('vue/dist/vue')

$(document).ready( function () {
  var vm = new Vue({
    el: ".image_upload",
    data: {
      selected_type: "detail_images",
      image_types: [{ text: '产品图片', value: 'detail_images' },
        { text: '功能图片', value: 'feature_images' },
        { text: '药丸图', value: 'content_images' },
        { text: 'QR码', value: 'qr_images' },
        { text: '其他图片', value: 'composition_images' },
      ],
      detail_id: 0,
      url_l: "/details",
      url: "",
      fnmae: "",
    },
    created() {
      var that = this;
      that.detail_id = parseInt($(".detail_id").text(), 10);
      that.url = `${this.url_l}/${this.detail_id}/${this.selected_type}`
      that.fname = `${this.selected_type}[image]`
    },
    watch: {
      selected_type() {
        var that = this;
        that.url = `${this.url_l}/${this.detail_id}/${this.selected_type}`
        that.fname = `${this.selected_type}[image]`
      }
    }
  })
})
