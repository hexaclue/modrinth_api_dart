import "package:modrinth_api/src/core/project/donation_platform.dart";
import "package:modrinth_api/src/core/project/gallery_image.dart";
import "package:modrinth_api/src/core/project/moderator_message.dart";
import "package:modrinth_api/src/core/project/project_enums.dart";
import "package:modrinth_api/src/core/project/project_license.dart";

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
  String slug;

  /// The title or name of the project
  String title;

  /// A short description of the project
  String description;

  /// A list of the categories that the project has
  List<String> categories;

  /// The client side support of the project
  ClientSide clientSide;

  /// The server side support of the project
  ServerSide serverSide;

  /// A long form description of the project
  String body;

  /// An optional link to where to submit bugs or issues with the project
  String? issuesUrl;

  /// An optional link to the source code of the project
  String? sourceUrl;

  /// An optional link to the project's wiki page or other relevant information
  String? wikiUrl;

  /// An optional invite link to the project's discord
  String? discordUrl;

  /// A list of donation links for the project
  List<DonationPlatform> donationUrls;

  /// The project type of the project
  ProjectType type;

  /// The total number of downloads of the project
  int downloads;

  /// The URL of the project's icon
  String? iconUrl;

  /// The RGB color of the project, automatically generated from the project icon
  int? color;

  /// The ID of the project, encoded as a base62 string
  String id;

  /// The ID of the team that has ownership of this project
  String team;

  /// The link to the long description of the project. Always null, only kept for legacy compatibility.
  @Deprecated("The link to the long description of the project. Always null, only kept for legacy compatibility.")
  Null bodyUrl;

  /// A message that a moderator sent regarding the project
  ModeratorMessage? moderatorMessage;

  /// The date the project was published
  DateTime published;

  /// The date the project was last updated
  DateTime updated;

  /// The date the project's status was set to approved or unlisted
  DateTime? approved;

  /// The total number of users following the project
  int followers;

  /// The status of the project
  ProjectStatus status;

  /// The license of the project
  ProjectLicense license;

  /// A list of the version IDs of the project (will never be empty unless `draft` status)
  List<String> versions;

  /// A list of all of the game versions supported by the project
  List<String> gameVersions;

  /// A list of all of the loaders supported by the project
  List<String> loaders;

  /// A list of images that have been uploaded to the project's gallery
  List<GalleryImage>? gallery;
}
