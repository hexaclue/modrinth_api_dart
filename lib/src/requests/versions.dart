import "dart:convert";

import "package:http/http.dart" as http;
import "package:modrinth_api/src/core/version/version.dart";
import "package:modrinth_api/src/modrinth.dart";

mixin VersionsRequests on IModrinthApi {
  /// Get a list of versions for a project.
  ///
  /// [idOrSlug] is the id or slug of the project to get. Can **not** be empty.
  ///
  /// [loaders] is a list of loaders to filter for. Can be null
  ///
  /// [gameVersions] is a list of game versions to filter for. Can be null
  ///
  /// [featured] is a boolean to filter for featured or non-featured versions. Can be null
  Future<List<Version>> getProjectVersions(
    String idOrSlug, {
    List<String>? loaders,
    List<String>? gameVersions,
    bool? featured,
  }) async {
    Uri uri = Uri.parse("${IModrinthApi.baseUrl}/project/$idOrSlug/version");

    final Map<String, String> queryParams = {};

    if (loaders != null) {
      queryParams["loaders"] = json.encode(loaders);
    }

    if (gameVersions != null) {
      queryParams["game_versions"] = json.encode(gameVersions);
    }

    if (featured != null) {
      queryParams["featured"] = featured.toString();
    }

    if (queryParams.isNotEmpty) {
      uri = uri.replace(queryParameters: queryParams);
    }

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get project versions.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    final List decoded = json.decode(res.body);

    return decoded.map((e) => Version.fromMap(e)).toList();
  }

  /// Get a version by its id.
  ///
  /// [id] is the id of the version to get. Can **not** be empty.
  Future<Version> getVersion(String id) async {
    final Uri uri = Uri.parse("${IModrinthApi.baseUrl}/version/$id");

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get version.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    return Version.fromMap(json.decode(res.body));
  }

  /// Get a multiple versions by their ids.
  ///
  /// [ids] is the id or slug of the project to get. Can **not** be empty.
  Future<List<Version>> getMultipleVersions(List<String> ids) async {
    Uri uri = Uri.parse("${IModrinthApi.baseUrl}/versions");

    final Map<String, String> queryParams = {};

    if (ids.isNotEmpty) {
      queryParams["ids"] = json.encode(ids);

      // No check needed as the ids list is not empty and therefore the query parameter is not empty
      uri = uri.replace(queryParameters: queryParams);
    }

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get multiple versions.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    final List decoded = json.decode(res.body);

    return decoded.map((e) => Version.fromMap(e)).toList();
  }
}
