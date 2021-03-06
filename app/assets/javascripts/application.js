// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.turbolinks
//= require turbolinks
//= require jquery.timepicker.js
//= require readable/loader
//= require moment
//= require daterangepicker

$(function() {
  $('.timepicker').timepicker({timeFormat: 'G:i'});
  $( ".datepicker" ).datepicker({dateFormat: 'yy-mm-dd'});
  $("#e1").daterangepicker({
      ranges: {
          'This month': [moment().startOf('month'), moment().endOf('month')],
          'Last month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
          'This week': [moment().startOf('week'), moment().endOf('week')],
          'Last week': [moment().subtract(1, 'week').startOf('week'), moment().subtract(1, 'week').endOf('week')],
          'Today': [moment().startOf('day'), moment().add(1, 'days').startOf('day')],
          'Yesterday': [moment().subtract(1, 'days').startOf('day'), moment().startOf('day')],
      },
      format:'YYYY/MM/DD'
  });
});
