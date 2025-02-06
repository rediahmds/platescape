enum AppRoute {
  home('/'),
  detail('/detail'),
  reviews('reviews');

  final String route;

  const AppRoute(this.route);
}
