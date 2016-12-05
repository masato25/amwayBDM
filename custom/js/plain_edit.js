var $ = require('jquery')
var Vue = require('vue/dist/vue')
var select2 = require('select2/dist/js/select2.full')
var _ = require('lodash')

$(document).ready( function (){
  Vue.component('b-select2', {
    props: ['options', 'value'],
    template:  '<select>\
          <option value="0" disabled> 请选择 </option>\
          <option v-for="option in options" v-bind:value="option.id"> {{ option.text }} </option>\
        </select>',
    mounted: function () {
      var vm = this
      $(this.$el)
        .val(this.value)
        // init select2
        .select2({ data: this.options })
        // emit event on change.
        .on('change', function () {
          vm.$emit('input', this.value)
        })
    },
    destroyed: function () {
      $(this.$el).off().select2('destroy')
    }
  })
        // <span v-if="value">{{options[value].brand_name}} {{options[value].series_name}}</span>
  var vm = new Vue({
    el: ".row",
    data: {
      details: [],
      selected_detail: 0,
    },
    mounted: function() {
      var that = this
      $.ajax({
        url: "/details_listall"
      }).done(function(data) {
        that.details = data
      })
    }
  })

})
