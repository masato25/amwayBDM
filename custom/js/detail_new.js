var $ = require('jquery')
var Vue = require('vue/dist/vue')
var select2 = require('select2/dist/js/select2.full')

$(document).ready( function () {
  Vue.component('b-select2', {
    props: ['options', 'value'],
    template: "<select>\
          <slot></slot>\
        </select>",
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
    watch: {
      value: function (value) {
        // update value
        $(this.$el).select2('val', this.value)
      },
      options: function (options) {
        // update options
        $(this.$el).select2({ data: this.options })
      }
    },
    destroyed: function () {
      $(this.$el).off().select2('destroy')
    }
  })

  Vue.component('s-select2', {
    data() {
      return {
        self_options: []
      }
    },
    props: ['options', 'value'],
    template: "<select>\
          <slot></slot>\
        </select>",
    mounted: function () {
      var vm = this
      vm.self_options = vm.options
      $(this.$el)
        .val(this.value)
        // init select2
        .select2({ data: vm.self_options })
        // emit event on change.
        .on('change', function () {
          vm.$emit('input', this.value)
        })
    },
    watch: {
      value: function (value) {
        // update value
        $(this.$el).select2('val', this.value)
      },
      options: function (options) {
        var that = this
        that.self_options = that.options
        // update options
        $(this.$el).select2({ data: that.self_options })
      }
    },
    destroyed: function () {
      $(this.$el).off().select2('destroy')
    }
  })

  var vm = new Vue({
    el: ".row",
    data: {
      brands: [],
      selected_brand: 0,
      series: [],
      selected_series: 0,
    },
    mounted: function() {
      var that = this
      $.ajax({
        url: "/brands.json"
      }).done(function(data) {
        that.brands = data
      })
    },
    watch: {
      selected_brand: function() {
        var that = this
        $.ajax({
          url: "/series/find/" + this.selected_brand
        }).done(function(data) {
          that.series = data
        })
      }
    }
  })


})
