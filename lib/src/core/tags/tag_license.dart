import "dart:convert";

/// Tag. Model used for licenses.
class TagLicense {
  TagLicense({
    required this.short,
    required this.name,
  });

  /// The short identifier of the license
  final String short;

  /// The full name of the license
  final String name;

  factory TagLicense.fromMap(Map<String, dynamic> map) {
    return TagLicense(
      short: map["short"]!,
      name: map["name"]!,
    );
  }

  factory TagLicense.fromJson(String source) => TagLicense.fromMap(json.decode(source));
}
