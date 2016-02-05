$(function () {
  $('#select-season').on('change', function () {
    var seasonId = '#season-' + $(this).val();
    $('.season-ranks').hide().filter(seasonId).show();
  });
});
