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

  loadRecentPlayers: function () {
    var view = this;
    return $.getJSON('/players', function (response) {
      view.model.set('recent_players', response);
    });
  },

  showProfile: function (e) {
    e.preventDefault();
    this.undelegateEvents();
    var player = new app.Player({ id: $(e.currentTarget).data('slug') });
    new app.PlayerView({ model: player }).render();
  }
});
