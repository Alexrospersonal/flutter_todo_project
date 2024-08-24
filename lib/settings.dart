final List<String> namesOfCaterories = [
  "Today"
      "😍Несортоване",
  "😄Home",
  "😇GYM",
  "😄Work",
  "😊Morning routine"
];

enum Filter {
  newest(name: "Newest"),
  oldest(name: "Oldest"),
  isComing(name: "Is coming"),
  important(name: "Important"),
  withFiles(name: "With files"),
  done(name: "Done"),
  overdue(name: "Overdue");

  const Filter({required this.name});

  final String name;

  static List<Filter> get filters => [
        newest,
        oldest,
        isComing,
        important,
        withFiles,
        done,
        overdue,
      ];
}
