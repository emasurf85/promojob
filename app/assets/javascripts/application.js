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
//= require foundation
//= require_tree .
//= require jquery-ui/datepicker


$(function() {
  $(document).foundation();
});

$("input.datepicker").each(function(input) {
  $(this).datepicker({
    dateFormat: "yy-mm-dd",
    altField: $(this).next()
  })

  // If you use i18n-js you can set the locale like that
  $(this).datepicker("option", $.datepicker.regional[I18n.currentLocale()]);
})