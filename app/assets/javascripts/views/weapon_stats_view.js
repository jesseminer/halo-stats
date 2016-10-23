app.WeaponStatsView = Backbone.View.extend({
  load: function () {
    var view = this;
    $.getJSON('/weapon_usages', { player_id: this.model.get('id') }).done(function (data) {
      view.render(data);
    });
  },

  render: function (data) {
    this.$el.html(app.template('players/weapon_stats', data));
  }
});
