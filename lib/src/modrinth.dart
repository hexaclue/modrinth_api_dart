import "package:http/http.dart" as http;
import "package:modrinth_api/src/internal/api_http_client.dart";
import "package:modrinth_api/src/requests/projects.dart";
import "package:modrinth_api/src/requests/versions.dart";

class IModrinthApi {
  IModrinthApi([this.apiKey]) {
    client = ApiHttpClient("@hihiqy1/modrinth_api_dart/0.0.0+infdev", http.Client());
  }

  /// The api key to use for requests
  final String? apiKey;

  /// The internal http client
  late final http.Client client;

  /// Closes the http client
  void dispose() {
    client.close();
  }

  /// The base url for the modrinth api
  static const String baseUrl = "https://api.modrinth.com/v2";
}

class ModrinthApi extends IModrinthApi with ProjectsRequests, VersionsRequests {
  ModrinthApi([super.apiKey]);
}
