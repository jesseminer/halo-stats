app.HeaderView = Backbone.View.extend({
  el: '#header',
  events: {
    'click .home-link': 'goHome'
  },

  goHome: function (e) {
    e.preventDefault();
    app.router.goToUrl(e.currentTarget.href);
  },

  render: function () {
    this.$el.html(app.template('header', {}));
    return this;
  }
});
