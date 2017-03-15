// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

// function readURL(input) {
//   if (input.files && input.files[0]) {
//     var reader = new FileReader();
//
//     reader.onload = function (e) {
//       $('#image-preview').attr('src', e.target.result);
//     }
//
//     reader.readAsDataURL(input.files[0])
//   }
// }
//
// $('#image-upload').change(function() {
//   readURL(this);
// });

var loadFile = function(event) {
  var output = document.getElementById('image-preview');
  output.src = URL.createObjectURL(event.target.files[0]);
};

$(function () {
        $('#datetimepicker6').datetimepicker({format: 'DD/MM/YYYY'});
        $('#datetimepicker7').datetimepicker({
            format: 'DD/MM/YYYY',
            useCurrent: false //Important! See issue #1075
        });
        $("#datetimepicker6").on("dp.change", function (e) {
            $('#datetimepicker7').data("DateTimePicker").minDate(e.date);
        });
        $("#datetimepicker7").on("dp.change", function (e) {
            $('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
        });
    });


