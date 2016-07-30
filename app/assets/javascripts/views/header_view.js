app.HeaderView = Backbone.View.extend({
  el: '#header',
  events: {
    'click .home-link': app.router.handleLinkClick
  },

  render: function () {
    this.$el.html(app.template('header', {}));
    return this;
  }
});
