import "dart:convert";

import "package:collection/collection.dart";

/// Tag. Model used for releases of the game and information about them.
class TagGameVersion {
  TagGameVersion({
    required this.version,
    required this.type,
    required this.date,
    required this.major,
  });

  /// The name/number of the game version
  final String version;

  /// The type of the game version
  final GameVersionType type;

  /// The date of the game version release
  final DateTime date;

  /// Whether or not this is a major version, used for Featured Versions
  final bool major;

  factory TagGameVersion.fromMap(Map<String, dynamic> map) {
    return TagGameVersion(
      version: map["version"]!,
      type:
          GameVersionType.values.firstWhereOrNull((element) => map["version_type"]! == element.name) ?? GameVersionType.values[0],
      date: DateTime.tryParse(map["date"]!) ?? DateTime(0),
      major: map["major"]!,
    );
  }

  factory TagGameVersion.fromJson(String source) => TagGameVersion.fromMap(json.decode(source));
}

enum GameVersionType { release, snapshot, alpha, beta }
