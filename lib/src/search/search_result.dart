import 'package:modrinth_api/src/project/project_enums.dart';

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
}
