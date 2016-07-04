app.FullPageView = Backbone.View.extend({
  el: '.container',

  context: function () {
    return this.model.toJSON();
  },

  render: function () {
    this.$el.html(app.template(this.template, this.context()));
  }
});
