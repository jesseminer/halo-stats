app.FullPageView = Backbone.View.extend({
  el: '.container',

  render: function () {
    this.$el.html(this.content);
  }
});
