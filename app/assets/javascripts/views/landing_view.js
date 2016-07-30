app.LandingView = app.FullPageView.extend({
  template: 'landing/show',
  events: {
    'click .player-listing': app.router.handleLinkClick
  },

  initialize: function () {
    this.model = new Backbone.Model();
    this.listenTo(this.model, 'change:recent_players', this.render);
    this.loadRecentPlayers();
  },

  loadRecentPlayers: function () {
    var view = this;
    return $.getJSON('/players', function (response) {
      view.model.set('recent_players', response);
    });
  }
});
