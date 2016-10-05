app.router = {
  currentPage: null,

  changePage: function (view) {
    if (app.router.currentPage) { app.router.currentPage.remove(); }
    app.router.currentPage = view;
    $('main').append(view.$el);
  },

  goToUrl: function (url) {
    history.pushState({}, '', url);
    app.router.loadState();
  },

  handleLinkClick: function (e) {
    e.preventDefault();
    app.router.goToUrl(e.currentTarget.href);
  },

  loadState: function () {
    var view;
    var page = window.location.pathname;
    $('#header .search-form').removeClass('hide');

    if (page === '/') {
      view = new app.LandingView().render();
    } else if (page.match(/\/players\/.*/)) {
      var player = new app.Player({ id: _.last(page.split('/')) });
      view = new app.PlayerView({ model: player });
    }
    if (view) { app.router.changePage(view); }
  }
};
