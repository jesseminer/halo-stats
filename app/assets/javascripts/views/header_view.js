app.HeaderView = Backbone.View.extend({
  el: '#header',
  events: {
    'click .home-link': app.router.handleLinkClick
  },

  initialize: function () {
    this.searchView = new app.SearchFormView();
  },

  render: function () {
    this.$el.html(app.template('header', {}));
    this.searchView.setElement(this.$('.search-form'));
    return this;
  }
});
