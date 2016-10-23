app.WeaponStatsView = Backbone.View.extend({
  events: {
    'change .game-mode': 'toggleGameMode',
    'change #include-power-weapons': 'togglePowerWeapons'
  },

  initialize: function () {
    this.settings = new Backbone.Model({ game_mode: 'arena', standard_weapon: true });
    this.listenTo(this.settings, 'change', this.filterWeapons);
  },

  filterWeapons: function () {
    var data = { weapons: _.filter(this.allWeapons, this.settings.toJSON()) };
    this.$('.weapons-wrapper').html(app.template('players/weapons', data));
    return this;
  },

  load: function () {
    var view = this;
    $.getJSON('/weapon_usages', { player_id: this.model.get('id') }).done(function (data) {
      view.allWeapons = data.weapons;
      view.render();
    });
  },

  render: function () {
    this.$el.html(app.template('players/weapon_stats_controls'));
    this.filterWeapons();
    return this;
  },

  toggleGameMode: function (e) {
    this.settings.set('game_mode', e.currentTarget.value);
  },

  togglePowerWeapons: function (e) {
    e.currentTarget.checked ?
      this.settings.unset('standard_weapon') :
      this.settings.set('standard_weapon', true);
  }
});
