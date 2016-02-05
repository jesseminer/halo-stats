$(function () {
  $('#include-power-weapons').on('change', function () {
    $(this).prop('checked') ?
      $('.weapon-listing').removeClass('hide') :
      $('.weapon-listing[data-weapontype!=Standard]').addClass('hide');
  });
});
