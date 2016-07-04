app.PlayerView = app.FullPageView.extend({
  content: '<div><span class="back">Back</span><br>Homjek</div>',
  events: {
    'click .back': 'backToLanding'
  },

  backToLanding: function () {
    this.undelegateEvents();
    new app.LandingView().render();
  }
});
