import "dart:convert";

/// Statistics about a Modrinth instance
class InstanceStatistics {
  InstanceStatistics({
    required this.projects,
    required this.versions,
    required this.files,
    required this.authors,
  });

  /// Number of projects on the instance
  final int projects;

  /// Number of versions on the instance
  final int versions;

  /// Number of version files on the instance
  final int files;

  /// Number of authors (users with projects) on the instance
  final int authors;

  factory InstanceStatistics.fromMap(Map<String, dynamic> map) {
    return InstanceStatistics(
      projects: map["projects"]!,
      versions: map["versions"]!,
      files: map["files"]!,
      authors: map["authors"]!,
    );
  }

  factory InstanceStatistics.fromJson(String source) => InstanceStatistics.fromMap(json.decode(source));
}
