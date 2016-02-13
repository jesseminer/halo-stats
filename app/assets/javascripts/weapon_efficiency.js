$(function () {
  $('#select-game-mode').on('change', function () {
    $('#arena-weapons, #warzone-weapons').addClass('hide');
    $('#' + $(this).val() + '-weapons').removeClass('hide');
  });

  $('#include-power-weapons').on('change', function () {
    $(this).prop('checked') ?
      $('.weapon-listing').removeClass('hide') :
      $('.weapon-listing[data-weapontype!=Standard]').addClass('hide');
  });
});
