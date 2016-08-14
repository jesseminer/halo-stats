app.PlayerView = app.FullPageView.extend({
  template: 'players/show',

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
    this.model.fetch();
  }
});
