$(function () {
  $('.datetimepicker').datetimepicker({
    format: I18n.t("datetime.format")
  });
  $('.datetimepicker1').on('dp.change', function (e) {
    $('.datetimepicker2').data('DateTimePicker').minDate(e.date);
  });
    $('.datetimepicker1').data('DateTimePicker').minDate(moment());

  $("#new_message").bind("ajax:complete", function (event, xhr, status) {
    $('.message_content').val('');
  });
});
$(document).ready(function () {
  materialKit.initFormExtendedDatetimepickers();
  materialKit.initSliders();
});
