app.Player = Backbone.Model.extend({
  urlRoot: '/players',

  updateRanksForSeason: function (seasonId) {
    return $.ajax({
      data: { season_id: seasonId },
      dataType: 'json',
      method: 'put',
      url: this.url() + '/update_ranks'
    });
  }
});
