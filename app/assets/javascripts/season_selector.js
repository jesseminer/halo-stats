$(function () {
  $('#select-season').on('change', function () {
    var seasonId = '#season-' + $(this).val();
    $('.season-ranks').addClass('hide').filter(seasonId).removeClass('hide');
  });
});
