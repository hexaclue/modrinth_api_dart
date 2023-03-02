import "package:collection/collection.dart";
import "package:modrinth_api/src/core/project/donation_platform.dart";
import "package:modrinth_api/src/core/project/gallery_image.dart";
import "package:modrinth_api/src/core/project/moderator_message.dart";
import "package:modrinth_api/src/core/project/project_enums.dart";
import "package:modrinth_api/src/core/project/project_license.dart";

/// A project on Modrinth. Could be anything, be it a mod, a resource pack, a data pack, or even a library.
class Project {
  Project({
    required this.slug,
    required this.title,
    required this.description,
    required this.categories,
    required this.clientSide,
    required this.serverSide,
    required this.body,
    this.issuesUrl,
    this.sourceUrl,
    this.wikiUrl,
    this.discordUrl,
    required this.donationUrls,
    required this.type,
    required this.downloads,
    this.iconUrl,
    this.color,
    required this.id,
    required this.team,
    this.bodyUrl,
    this.moderatorMessage,
    required this.published,
    required this.updated,
    this.approved,
    required this.followers,
    required this.status,
    required this.license,
    required this.versions,
    required this.gameVersions,
    required this.loaders,
    this.gallery,
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

  /// A long form description of the project
  final String body;

  /// An optional link to where to submit bugs or issues with the project
  final String? issuesUrl;

  /// An optional link to the source code of the project
  final String? sourceUrl;

  /// An optional link to the project's wiki page or other relevant information
  final String? wikiUrl;

  /// An optional invite link to the project's discord
  final String? discordUrl;

  /// A list of donation links for the project
  final List<DonationPlatform> donationUrls;

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

  /// The ID of the team that has ownership of this project
  final String team;

  /// The link to the long description of the project. Always null, only kept for legacy compatibility.
  @Deprecated("The link to the long description of the project. Always null, only kept for legacy compatibility.")
  final Null bodyUrl;

  /// A message that a moderator sent regarding the project
  final ModeratorMessage? moderatorMessage;

  /// The date the project was published
  final DateTime published;

  /// The date the project was last updated
  final DateTime updated;

  /// The date the project's status was set to approved or unlisted
  final DateTime? approved;

  /// The total number of users following the project
  final int followers;

  /// The status of the project
  final ProjectStatus status;

  /// The license of the project
  final ProjectLicense license;

  /// A list of the version IDs of the project (will never be empty unless `draft` status)
  final List<String> versions;

  /// A list of all of the game versions supported by the project
  final List<String> gameVersions;

  /// A list of all of the loaders supported by the project
  final List<String> loaders;

  /// A list of images that have been uploaded to the project's gallery
  final List<GalleryImage>? gallery;

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      slug: map["slug"]!,
      title: map["title"]!,
      description: map["description"]!,
      categories: List<String>.from(map["categories"]!),
      clientSide: ClientSide.values.firstWhereOrNull((element) => map["client_side"] == element.name) ?? ClientSide.values[0],
      serverSide: ServerSide.values.firstWhereOrNull((element) => map["server_side"] == element.name) ?? ServerSide.values[0],
      body: map["body"]!,
      issuesUrl: map["issues_url"],
      sourceUrl: map["source_url"],
      wikiUrl: map["wiki_url"],
      discordUrl: map["discord_url"],
      donationUrls: List<DonationPlatform>.from(((map["donation_urls"] ?? []) as List).map((x) => DonationPlatform.fromMap(x))),
      type: ProjectType.values.firstWhereOrNull((element) => map["project_type"] == element.name) ?? ProjectType.values[0],
      downloads: map["downloads"]!,
      iconUrl: map["icon_url"],
      color: map["color"],
      id: map["id"]!,
      team: map["team"]!,
      published: DateTime.parse(map["published"]!),
      updated: DateTime.parse(map["updated"]!),
      approved: DateTime.tryParse(map["approved"] ?? ""),
      followers: map["followers"]!,
      status: ProjectStatus.values.firstWhereOrNull((element) => map["status"] == element.name) ?? ProjectStatus.values[0],
      license: ProjectLicense.fromMap(map["license"]!),
      versions: List<String>.from(map["versions"]!),
      gameVersions: List<String>.from(map["game_versions"]!),
      loaders: List<String>.from(map["loaders"]!),
      gallery: List<GalleryImage>.from(((map["gallery"] ?? []) as List).map((x) => GalleryImage.fromMap(x))),
    );
  }

  @override
  String toString() {
    return "Project(slug: $slug, title: $title)";
  }

  String toLongString() {
    return "Project(slug: $slug, title: $title, description: $description, categories: $categories, clientSide: $clientSide, serverSide: $serverSide, body: $body, issuesUrl: $issuesUrl, sourceUrl: $sourceUrl, wikiUrl: $wikiUrl, discordUrl: $discordUrl, donationUrls: $donationUrls, type: $type, downloads: $downloads, iconUrl: $iconUrl, color: $color, id: $id, team: $team, bodyUrl (DEPRECATED): $bodyUrl, moderatorMessage: $moderatorMessage, published: $published, updated: $updated, approved: $approved, followers: $followers, status: $status, license: $license, versions: $versions, gameVersions: $gameVersions, loaders: $loaders, gallery: $gallery)";
  }
}
