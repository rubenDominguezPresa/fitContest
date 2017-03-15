// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require best_in_place
//= require jquery_ujs
//= require bootstrap-sprockets
//= require moment
//= require bootstrap-datetimepicker
//= require 'jquery.dynatable'
//= requir bootstrap.min
//= requir lightbox.min
//= requir wow.min
//= requir main  
//= require_tree .

$(document).ready(function() {
  /* Activating Best In Place */
  //alert('hola')
 //jQuery(".best_in_place").best_in_place();
  
  $("a[data-remote]").on('ajax:success', function(e, data, status, xhr) {
  	$("div.add-ajax").empty();  
    $("div.add-ajax").append(data);
    $('#duel_table').dynatable({
      table: {
        defaultColumnIdStyle: 'underscore'
      }
    });
  });
})


