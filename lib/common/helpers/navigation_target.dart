class NavigationTarget {
  final String value;
  final bool isUrl;

  NavigationTarget.url(this.value) : isUrl = true;

  NavigationTarget.screen(this.value) : isUrl = false;
}
