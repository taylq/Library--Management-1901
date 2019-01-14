$(function () {
  $('.datetimepicker').datetimepicker({
    format: 'DD/MM/YYYY HH:mm'
  });
  $('.datetimepicker1').on('dp.change', function (e) {
    $('.datetimepicker2').data('DateTimePicker').minDate(e.date);
  });
    $('.datetimepicker1').data('DateTimePicker').minDate(moment());
});
$(document).ready(function () {
  materialKit.initFormExtendedDatetimepickers();
  materialKit.initSliders();
});
