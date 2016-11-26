app.SeasonSelectorView = Backbone.View.extend({
  events: {
    'change select': 'changeSeason'
  },

  initialize: function () {
    _.bindAll(this, 'addNewRanks');
  },

  addNewRanks: function (response) {
    _.remove(this.allRanks, { season_id: response.season_id });
    this.allRanks = this.allRanks.concat(response.ranks);
    this.filterBySeason(response.season_id).renderRanks();
  },

  changeSeason: function (e) {
    var seasonId = parseInt($(e.currentTarget).val());
    if (_.includes(this.model.get('completed_seasons'), seasonId.toString())) {
      this.filterBySeason(seasonId).renderRanks();
    } else {
      this.$('.ranks-wrapper').text('Loading...');
      this.model.updateRanksForSeason(seasonId).done(this.addNewRanks);
    }
  },

  filterBySeason: function (seasonId) {
    this.playlistRanks = _.filter(this.allRanks, { season_id: seasonId });
    return this;
  },

  loadRanks: function () {
    var view = this;
    $.getJSON('/playlist_ranks', { player_id: this.model.get('id') }).done(function (data) {
      view.allRanks = data.playlist_ranks;
      view.seasons = data.seasons;
      view.filterBySeason(data.seasons[0].id).render();
    });
  },

  render: function () {
    this.$el.html(app.template('players/season_selector', { seasons: this.seasons }));
    this.renderRanks();
    return this;
  },

  renderRanks: function () {
    this.$('.ranks-wrapper').html(app.template('players/playlist_ranks', { playlist_ranks: this.playlistRanks }));
  }
});
