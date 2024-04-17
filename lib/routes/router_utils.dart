enum Pages {
  home,
  addTodo,
  more,
  info
}

extension AppPageExtension on Pages {
  String get screenPath {
    return switch (this) {
      Pages.home => '/',
      Pages.addTodo => 'add_todo',
      Pages.more => 'more',
      Pages.info => 'info'
    };
  }

  String get screenName {
    return switch (this) {
      Pages.home => 'HOME',
      Pages.addTodo => 'ADDTODO',
      Pages.more => 'MORE',
      Pages.info => "INFO"
    };
  }
}