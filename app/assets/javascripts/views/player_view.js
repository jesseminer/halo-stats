app.PlayerView = app.FullPageView.extend({
  template: 'players/show',
  events: {
    'click .refresh-btn': 'refreshStats'
  },

  initialize: function () {
    this.seasonSelectorView = new app.SeasonSelectorView({ model: this.model });
    this.weaponStatsView = new app.WeaponStatsView({ model: this.model });
    this.listenTo(this.model, 'sync', this.render);
    this.model.fetch();
  },

  refreshStats: function (e) {
    $(e.currentTarget).prop('disabled', true);
    this.model.save();
  },

  renderSubviews: function () {
    this.seasonSelectorView.setElement(this.$('.playlist-ranks')).loadRanks();
    this.weaponStatsView.setElement(this.$('.weapon-stats')).load();
  }
});
