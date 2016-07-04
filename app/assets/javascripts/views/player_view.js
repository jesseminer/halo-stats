app.PlayerView = app.FullPageView.extend({
  template: 'players/show',
  events: {
    'click .back': 'backToLanding'
  },

  initialize: function () {
    this.listenTo(this.model, 'change', this.render);
    this.model.fetch();
  },

  backToLanding: function () {
    this.undelegateEvents();
    new app.LandingView().render();
  }
});
