class Dependency {
  Dependency({
    this.versionId,
    this.projectId,
    this.fileName,
    required this.type,
  });

  final String? versionId;
  final String? projectId;
  final String? fileName;
  final DependencyType type;
}

enum DependencyType { required, optional, incompatible, embedded }
