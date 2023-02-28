import "dart:convert";

import "package:modrinth_api/src/core/project/project.dart";
import "package:modrinth_api/src/core/version/version.dart";

/// A class that represents the dependencies of a project.
///
/// I don't know why this is structured in this way, but it is like this in the api...
class ProjectDependencies {
  ProjectDependencies({
    required this.projects,
    required this.versions,
  });

  /// Projects that the above project depends on
  final List<Project> projects;

  /// Versions of the [projects] that the above project depends on
  final List<Version> versions;

  factory ProjectDependencies.fromMap(Map<String, dynamic> map) {
    return ProjectDependencies(
      projects: List<Project>.from(map["projects"]?.map((x) => Project.fromMap(x))),
      versions: List<Version>.from(map["versions"]?.map((x) => Version.fromMap(x))),
    );
  }

  factory ProjectDependencies.fromJson(String source) => ProjectDependencies.fromMap(json.decode(source));
}
