app.SearchFormView = Backbone.View.extend({
  events: {
    'submit': 'search'
  },

  initialize: function () {
    _.bindAll(this, 'onError');
  },

  onError: function (response) {
    this.$('input[type=submit]').prop('disabled', false);
    this.$('.error').text(response.responseJSON.error).removeClass('hide');
  },

  search: function (e) {
    e.preventDefault();
    this.$('input[type=submit]').prop('disabled', true);
    this.$('.error').empty().addClass('hide');
    var params = { gamertag: this.$('input[name=gamertag]').val() };
    $.getJSON('/players/search', params).then(this.showPlayerProfile, this.onError);
  },

  showPlayerProfile: function (response) {
    app.router.goToUrl('/players/' + response.slug);
  }
});
