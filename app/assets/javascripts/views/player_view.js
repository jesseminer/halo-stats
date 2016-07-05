app.PlayerView = app.FullPageView.extend({
  template: 'players/show',

  initialize: function () {
    this.listenTo(this.model, 'change', this.render);
    this.model.fetch();
  }
});
