import "dart:convert";

import "package:collection/collection.dart";

class VersionDependency {
  VersionDependency({
    this.versionId,
    this.projectId,
    this.fileName,
    required this.type,
  });

  final String? versionId;
  final String? projectId;
  final String? fileName;
  final DependencyType type;

  factory VersionDependency.fromMap(Map<String, dynamic> map) {
    return VersionDependency(
      versionId: map["version_id"],
      projectId: map["project_id"],
      fileName: map["filename"],
      type:
          DependencyType.values.firstWhereOrNull((element) => map["dependency_type"] == element.name) ?? DependencyType.values[0],
    );
  }

  factory VersionDependency.fromJson(String source) => VersionDependency.fromMap(json.decode(source));
}

enum DependencyType { required, optional, incompatible, embedded }
