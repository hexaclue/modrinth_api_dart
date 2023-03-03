import "dart:convert";

import "package:http/http.dart" as http;
import "package:modrinth_api/src/internal/api_http_client.dart";
import 'package:modrinth_api/src/requests/miscellaneous.dart';
import "package:modrinth_api/src/requests/projects.dart";
import 'package:modrinth_api/src/requests/tags.dart';
import "package:modrinth_api/src/requests/teams.dart";
import "package:modrinth_api/src/requests/users.dart";
import "package:modrinth_api/src/requests/versions.dart";

class IModrinthApi {
  IModrinthApi({required this.project, this.apiKey}) {
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

  /// Closes the http client
  void dispose() {
    client.close();
  }

  /// The base url for the modrinth api
  static const String baseUrl = "https://api.modrinth.com/v2";
}

/// The main class for the Modrinth API.
///
/// [project] is the project name to use for requests to the API. PLEASE use a unique name for your project. Include a version number if possible.
class ModrinthApi extends IModrinthApi
    with ProjectsRequests, VersionsRequests, UsersRequests, TeamsRequests, TagsRequests, MiscellaneousRequests {
  ModrinthApi({
    required super.project,
    super.apiKey,
  });
}
