app.SeasonSelectorView = Backbone.View.extend({
  initialize: function () {
    _.bindAll(this, 'render');
  },

  loadRanks: function () {
    $.getJSON('/playlist_ranks', { player_id: this.model.get('id') }).done(this.render);
  },

  render: function (data) {
    this.$el.html(app.template('players/playlist_ranks', data));
    return this;
  }
});
