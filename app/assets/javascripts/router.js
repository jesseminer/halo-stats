app.router = {
  currentPage: null,

  changePage: function (view) {
    if (app.router.currentPage) { app.router.currentPage.remove(); }
    app.router.currentPage = view;
  },

  goToUrl: function (url) {
    history.pushState({}, '', url);
    app.router.loadState();
  },

  loadState: function () {
    var view;
    var page = window.location.pathname;

    if (page === '/') {
      view = new app.LandingView().render();
    } else if (page.match(/\/players\/.*/)) {
      var player = new app.Player({ id: _.last(page.split('/')) });
      view = new app.PlayerView({ model: player });
    }
    if (view) { app.router.changePage(view); }
  }
};

window.onpopstate = app.router.loadState;
