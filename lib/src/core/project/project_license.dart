/// The license of the project
class ProjectLicense {
  ProjectLicense({
    required this.id,
    required this.name,
    this.url,
  });

  /// The SPDX license ID of a project
  final String id;

  /// The long name of a license. Can be empty
  final String name;

  /// The URL to this license
  final String? url;

  factory ProjectLicense.fromMap(Map<String, dynamic> map) => ProjectLicense(
        id: map["id"]!,
        name: map["name"]!,
        url: map["url"],
      );

  @override
  String toString() {
    return "ProjectLicense(id: $id, name: $name)";
  }
}
