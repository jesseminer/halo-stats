app.LandingView = app.FullPageView.extend({
  template: 'landing/show',
  events: {
    'click .player-listing': 'showProfile'
  },

  initialize: function () {
    this.model = new Backbone.Model();
    this.listenTo(this.model, 'change:recent_players', this.render);
    this.loadRecentPlayers();
  },

  addToHistory: function () {
    history.pushState({ page: 'landing' }, '', '/');
  },

  loadRecentPlayers: function () {
    var view = this;
    return $.getJSON('/players', function (response) {
      view.model.set('recent_players', response);
    });
  },

  showProfile: function (e) {
    e.preventDefault();
    var player = new app.Player({ id: $(e.currentTarget).data('slug') });
    app.router.changePage(new app.PlayerView({ model: player }));
  }
});
