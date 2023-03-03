import "dart:convert";

/// Tag. Model used for loaders, e.g. Forge, Fabric, but also Vanilla.
class TagLoader {
  TagLoader({
    required this.icon,
    required this.name,
    required this.projectTypes,
  });

  /// The SVG icon of the loader
  final String icon;

  /// The name of the loader
  final String name;

  /// The project types this loader is applicable to
  final List<String> projectTypes;

  factory TagLoader.fromMap(Map<String, dynamic> map) {
    return TagLoader(
      icon: map["icon"]!,
      name: map["name"]!,
      projectTypes: map["project_types"]!,
    );
  }

  factory TagLoader.fromJson(String source) => TagLoader.fromMap(json.decode(source));
}
