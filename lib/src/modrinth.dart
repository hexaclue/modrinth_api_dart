import "dart:convert";

import "package:http/http.dart" as http;
import "package:modrinth_api/src/internal/api_http_client.dart";
import "package:modrinth_api/src/requests/miscellaneous.dart";
import "package:modrinth_api/src/requests/projects.dart";
import "package:modrinth_api/src/requests/tags.dart";
import "package:modrinth_api/src/requests/teams.dart";
import "package:modrinth_api/src/requests/users.dart";
import "package:modrinth_api/src/requests/versions.dart";

class IModrinthApi {
  IModrinthApi({
    required this.project,
    this.apiKey,
    this.baseUrl = "https://api.modrinth.com/v2",
  }) {
    try {
      ascii.encode(project);
    } catch (e) {
      throw ArgumentError("Project name must be in ASCII format. Currently, it contains non-ASCII characters.");
    }

    client = ApiHttpClient("@hihiqy1/modrinth_api_dart/0.0.0+infdev|user=$project", http.Client(), apiKey);
  }

  /// The api key to use for requests
  final String? apiKey;

  /// The project name to use for requests
  final String project;

  /// The internal http client
  late final http.Client client;

  /// The base url for the modrinth api
  final String baseUrl;

  /// Closes the http client
  void dispose() {
    client.close();
  }
}

/// The main class for the Modrinth API.
///
/// [project] is the project name to use for requests to the API. PLEASE use a unique name for your project. Include a version number if possible.
///
/// [apiKey] is the api key to use for requests to the API.
///
/// [baseUrl] is the base url for the Modrinth API. Generally, this doesn't need to be changed.
/// If you're going to use the staging API (for testing purposes, may be wiped at any time), you can change this to `"https://staging-api.modrinth.com/v2"`.
/// Note that the [baseUrl] includes the version path, but without the trailing slash.
class ModrinthApi extends IModrinthApi
    with ProjectsRequests, VersionsRequests, UsersRequests, TeamsRequests, TagsRequests, MiscellaneousRequests {
  ModrinthApi({
    required super.project,
    super.apiKey,
    super.baseUrl,
  });
}
