app.PlayerView = app.FullPageView.extend({
  template: 'players/show',
  events: {
    'click .refresh-btn': 'refreshStats'
  },

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
    this.model.fetch();
  },

  refreshStats: function (e) {
    $(e.currentTarget).prop('disabled', true);
    this.model.save();
  }
});
