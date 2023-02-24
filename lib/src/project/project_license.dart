/// The license of the project
class ProjectLicense {
  ProjectLicense({
    required this.id,
    required this.name,
    this.url,
  });

  /// The SPDX license ID of a project
  String id;

  /// The long name of a license
  String name;

  /// The URL to this license
  String? url;
}
