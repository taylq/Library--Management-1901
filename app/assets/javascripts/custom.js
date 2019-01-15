$(function () {
  $('.datetimepicker').datetimepicker({
    format: I18n.t("datetime.format")
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
