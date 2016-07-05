app.router = {
  currentPage: null,

  changePage: function (view, addToHistory) {
    if (typeof addToHistory === 'undefined') { addToHistory = true; }
    if (app.router.currentPage) { app.router.currentPage.remove(); }
    app.router.currentPage = view;
    if (addToHistory) { view.addToHistory(); }
  },

  loadState: function (e) {
    if (e.state.page === 'landing') {
      app.router.changePage(new app.LandingView().render(), false);
    } else if (e.state.page === 'player') {
      var player = new app.Player({ id: e.state.slug });
      app.router.changePage(new app.PlayerView({ model: player }), false);
    }
  }
};

window.onpopstate = app.router.loadState;
