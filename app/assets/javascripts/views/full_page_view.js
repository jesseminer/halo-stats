app.FullPageView = Backbone.View.extend({
  showHeaderSearch: true,

  context: function () {
    return this.model.toJSON();
  },

  render: function () {
    this.$el.html(app.template(this.template, this.context()));
    this.renderSubviews();
    return this;
  },

  renderSubviews: _.noop
});
