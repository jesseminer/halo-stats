app.LandingView = app.FullPageView.extend({
  template: 'landing/show',
  events: {
    'click .player-listing': app.router.handleLinkClick,
    'submit .search-form': 'search'
  },

  initialize: function () {
    this.model = new Backbone.Model();
    this.listenTo(this.model, 'change:recent_players', this.render);
    _.bindAll(this, 'onError');
    this.loadRecentPlayers();
  },

  loadRecentPlayers: function () {
    var view = this;
    return $.getJSON('/players', function (response) {
      view.model.set('recent_players', response);
    });
  },

  onError: function (response) {
    this.$('.error').text(response.responseJSON.error).removeClass('hide');
  },

  search: function (e) {
    e.preventDefault();
    var params = { gamertag: this.$('input[name=gamertag]').val() };
    $.post('/players/search', params, null, 'json').then(this.showPlayerProfile, this.onError);
  },

  showPlayerProfile: function (response) {
    app.router.goToUrl('/players/' + response.slug);
  }
});
