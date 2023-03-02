import "package:collection/collection.dart";

import "package:modrinth_api/src/core/project/project_enums.dart";

/// Project search result.
///
/// As opposed to [Project], this class does not contain all the information about a project.
class SearchResult {
  SearchResult({
    required this.slug,
    required this.title,
    required this.description,
    required this.categories,
    required this.clientSide,
    required this.serverSide,
    required this.type,
    required this.downloads,
    this.iconUrl,
    this.color,
    required this.id,
    required this.author,
    required this.displayCategories,
    required this.versions,
    required this.follows,
    required this.created,
    required this.modified,
    required this.latestVersion,
    required this.license,
    this.gallery,
    this.featuredGallery,
  });

  /// The slug of a project, used for vanity URLs. Regex: ```^[\w!@$()`.+,"\-']{3,64}$```
  final String slug;

  /// The title or name of the project
  final String title;

  /// A short description of the project
  final String description;

  /// A list of the categories that the project has
  final List<String> categories;

  /// The client side support of the project
  final ClientSide clientSide;

  /// The server side support of the project
  final ServerSide serverSide;

  /// The project type of the project
  final ProjectType type;

  /// The total number of downloads of the project
  final int downloads;

  /// The URL of the project's icon
  final String? iconUrl;

  /// The RGB color of the project, automatically generated from the project icon
  final int? color;

  /// The ID of the project, encoded as a base62 string
  final String id;

  /// The username of the project's author
  final String author;

  /// A list of the categories that the project has which are not secondary
  final List<String> displayCategories;

  /// A list of the minecraft versions supported by the project
  final List<String> versions;

  /// The total number of users following the project
  final int follows;

  /// The date the project was added to search
  final DateTime created;

  /// The date the project was last modified
  final DateTime modified;

  /// The latest version of minecraft that this project supports
  final String latestVersion;

  /// The SPDX license ID of a project
  final String license;

  /// All gallery images attached to the project
  final List<String>? gallery;

  /// The featured gallery image of the project
  final String? featuredGallery;

  factory SearchResult.fromMap(Map<String, dynamic> map) {
    return SearchResult(
      slug: map["slug"] ?? "",
      title: map["title"] ?? "",
      description: map["description"] ?? "",
      categories: List<String>.from(map["categories"]),
      clientSide: ClientSide.values.firstWhereOrNull((element) => map["client_side"] == element.name) ?? ClientSide.values[0],
      serverSide: ServerSide.values.firstWhereOrNull((element) => map["server_side"] == element.name) ?? ServerSide.values[0],
      type: ProjectType.values.firstWhereOrNull((element) => map["project_type"] == element.name) ?? ProjectType.values[0],
      downloads: map["downloads"]?.toInt() ?? -1,
      iconUrl: map["icon_url"],
      color: map["color"]?.toInt(),
      id: map["project_id"] ?? "",
      author: map["author"] ?? "",
      displayCategories: List<String>.from(map["display_categories"]),
      versions: List<String>.from(map["versions"]),
      follows: map["follows"]?.toInt() ?? -1,
      created: DateTime.tryParse(map["date_created"]) ?? DateTime(0),
      modified: DateTime.tryParse(map["date_modified"]) ?? DateTime(0),
      latestVersion: map["latest_version"] ?? "",
      license: map["license"] ?? "",
      gallery: List<String>.from(map["gallery"]),
      featuredGallery: map["featured_gallery"],
    );
  }

  @override
  String toString() {
    return "SearchResult(slug: $slug, title: $title)";
  }

  String toLongString() {
    return "SearchResult(slug: $slug, title: $title, description: $description, categories: $categories, clientSide: $clientSide, serverSide: $serverSide, type: $type, downloads: $downloads, iconUrl: $iconUrl, color: $color, id: $id, author: $author, displayCategories: $displayCategories, versions: $versions, follows: $follows, created: $created, modified: $modified, latestVersion: $latestVersion, license: $license, gallery: $gallery, featuredGallery: $featuredGallery)";
  }
}
