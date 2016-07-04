app.LandingView = app.FullPageView.extend({
  content: '<div>Hi<br><span class="player">Profile</span></div>',
  events: {
    'click .player': 'playerProfile'
  },

  playerProfile: function () {
    this.undelegateEvents();
    new app.PlayerView().render();
  }
});
