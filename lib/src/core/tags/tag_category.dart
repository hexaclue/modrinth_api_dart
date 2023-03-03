import "dart:convert";

/// Tag. Model used for categories of projects.
class TagCategory {
  TagCategory({
    required this.icon,
    required this.name,
    required this.projectType,
    required this.header,
  });

  /// The SVG icon of a category
  final String icon;

  /// The name of a category
  final String name;

  /// The project type this category is applicable to
  final String projectType;

  /// The header under which the category should go
  final String header;

  factory TagCategory.fromMap(Map<String, dynamic> map) {
    return TagCategory(
      icon: map["icon"]!,
      name: map["name"]!,
      projectType: map["project_type"]!,
      header: map["header"]!,
    );
  }

  factory TagCategory.fromJson(String source) => TagCategory.fromMap(json.decode(source));
}
