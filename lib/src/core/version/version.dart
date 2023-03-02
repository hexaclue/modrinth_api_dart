import "dart:convert";

import "package:collection/collection.dart";
import "package:modrinth_api/src/core/version/version_dependency.dart";
import "package:modrinth_api/src/core/version/version_file.dart";

class Version {
  Version({
    required this.name,
    required this.versionNumber,
    this.changelog,
    required this.dependencies,
    required this.gameVersions,
    required this.releaseChannel,
    required this.loaders,
    required this.featured,
    required this.status,
    this.requestedStatus,
    required this.id,
    required this.projectId,
    required this.authorId,
    required this.published,
    required this.downloads,
    required this.changelogUrl,
    required this.files,
  });

  /// The name of this version
  final String name;

  /// The version number. Ideally will follow semantic versioning
  final String versionNumber;

  /// The changelog for this version
  final String? changelog;

  /// A list of specific versions of projects that this version depends on
  final List<VersionDependency> dependencies;

  /// A list of versions of Minecraft that this version supports
  final List<String> gameVersions;

  /// The release channel for this version
  final ReleaseChannel releaseChannel;

  /// The mod loaders that this version supports
  final List<String> loaders;

  /// Whether the version is featured or not
  final bool featured;

  final VersionStatus status;

  final RequestedStatus? requestedStatus;

  /// The ID of the version, encoded as a base62 string
  final String id;

  /// The ID of the project this version is for
  final String projectId;

  /// The ID of the author who published this version
  final String authorId;

  /// The date and time that this version was published
  final DateTime published;

  /// The number of times this version has been downloaded
  final int downloads;

  /// A link to the changelog for this version. Always null, only kept for legacy compatibility.
  @Deprecated("A link to the changelog for this version. Always null, only kept for legacy compatibility.")
  final Null changelogUrl;

  /// A list of files available for download for this version
  final List<VersionFile> files;

  factory Version.fromMap(Map<String, dynamic> map) {
    return Version(
      name: map["name"]!,
      versionNumber: map["version_number"]!,
      changelog: map["changelog"],
      dependencies: List<VersionDependency>.from((map["dependencies"]! as List).map((x) => VersionDependency.fromMap(x))),
      gameVersions: List<String>.from(map["game_versions"]!),
      releaseChannel:
          ReleaseChannel.values.firstWhereOrNull((element) => map["version_type"] == element.name) ?? ReleaseChannel.values[0],
      loaders: List<String>.from(map["loaders"]!),
      featured: map["featured"]!,
      status: VersionStatus.values.firstWhereOrNull((element) => map["status"] == element.name) ?? VersionStatus.values[0],
      requestedStatus: RequestedStatus.values.firstWhereOrNull((element) => map["requested_status"] == element.name),
      id: map["id"]!,
      projectId: map["project_id"]!,
      authorId: map["author_id"]!,
      published: DateTime.tryParse(map["date_published"]) ?? DateTime(0),
      downloads: map["downloads"]!,
      changelogUrl: null,
      files: List<VersionFile>.from((map["files"]! as List).map((x) => VersionFile.fromMap(x))),
    );
  }

  factory Version.fromJson(String source) => Version.fromMap(json.decode(source));

  @override
  String toString() {
    return "Version(name: $name, versionNumber: $versionNumber)";
  }

  String toLongString() {
    return "Version(name: $name, versionNumber: $versionNumber, changelog: $changelog, dependencies: $dependencies, gameVersions: $gameVersions, releaseChannel: $releaseChannel, loaders: $loaders, featured: $featured, status: $status, requestedStatus: $requestedStatus, id: $id, projectId: $projectId, authorId: $authorId, published: $published, downloads: $downloads, changelogUrl (DEPRECATED): $changelogUrl, files: $files)";
  }
}

enum ReleaseChannel { release, beta, alpha }

enum VersionStatus { listed, archived, draft, unlisted, scheduled, unknown }

enum RequestedStatus { listed, archived, draft, unlisted }
