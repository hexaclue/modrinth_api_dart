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
    Uri uri = Uri.parse("$baseUrl/project/$idOrSlug/version");

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
    final Uri uri = Uri.parse("$baseUrl/version/$id");

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
    Uri uri = Uri.parse("$baseUrl/versions");

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

  /// Get a version from a file hash.
  ///
  /// [hash] is the hash of the file to get the version for. Can **not** be empty.
  ///
  /// [algorithm] is the algorithm used to hash the file. Default is [HashAlgorithm.sha1]
  ///
  /// [multiple] is whether to return multiple results when looking for this hash. This is useful for when a file is uploaded multiple times. Default is false.
  Future<Version> getVersionFromHash(
    String hash, {
    HashAlgorithm algorithm = HashAlgorithm.sha1,
    bool? multiple,
  }) async {
    final Uri uri = Uri.parse("$baseUrl/version_file/$hash");

    final Map<String, String> queryParams = {
      "algorithm": algorithm.name,
    };

    if (multiple != null) {
      queryParams["multiple"] = multiple.toString();
    }

    uri.replace(queryParameters: queryParams);

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get version from hash.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    return Version.fromMap(json.decode(res.body));
  }

  /// Get multiple versions from file hashes.
  ///
  /// [hashes] is the list of hashes of files to get the version for. Can **not** be empty.
  ///
  /// [algorithm] is the algorithm used to hash the files. Note that the algorithm must be the same for all hashes. Default is [HashAlgorithm.sha1]
  Future<List<Version>> getMultipleVersionsFromHashes(
    List<String> hashes, {
    HashAlgorithm algorithm = HashAlgorithm.sha1,
  }) async {
    final Uri uri = Uri.parse("$baseUrl/version_files");

    final http.Response res = await client.post(
      uri,
      body: json.encode(
        {
          "hashes": hashes,
          "algorithm": algorithm.name,
        },
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to get versions from hashes.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    final Map decoded = json.decode(res.body);

    return decoded.values.map((e) => Version.fromMap(e)).toList();
  }

  /// Get latest version of a project, from an exising version file hash, filtering by loaders and game versions.
  ///
  /// [hash] is the hash of the file to get the version for. Can **not** be empty.
  ///
  /// [loaders] is the list of loaders to filter by. Can **not** be empty.
  ///
  /// [gameVersions] is the list of game versions to filter by. Can **not** be empty.
  ///
  /// [algorithm] is the algorithm used to hash the file. Default is [HashAlgorithm.sha1]
  Future<Version> getLatestVersionFromHash({
    required String hash,
    required List<String> loaders,
    required List<String> gameVersions,
    HashAlgorithm algorithm = HashAlgorithm.sha1,
  }) async {
    final Uri uri = Uri.parse("$baseUrl/version_file/$hash/update");

    final Map<String, String> queryParams = {
      "algorithm": algorithm.name,
    };

    uri.replace(queryParameters: queryParams);

    final http.Response res = await client.post(
      uri,
      body: json.encode(
        {
          "loaders": loaders,
          "game_versions": gameVersions,
        },
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to get version from hash.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    return Version.fromMap(json.decode(res.body));
  }

  /// Get latest versions of multiple projects, from exising version file hashes, filtering by loaders and game versions.
  ///
  /// [hashes] is the list of hashes of files to get the latest versions for. Can **not** be empty.
  ///
  /// [loaders] is the list of loaders to filter by. Can **not** be empty.
  ///
  /// [gameVersions] is the list of game versions to filter by. Can **not** be empty.
  ///
  /// [algorithm] is the algorithm used to hash the files. Note that the algorithm must be the same for all hashes. Default is [HashAlgorithm.sha1]
  Future<List<Version>> getMultipleLatestVersionsFromHashes({
    required List<String> hashes,
    required List<String> loaders,
    required List<String> gameVersions,
    HashAlgorithm algorithm = HashAlgorithm.sha1,
  }) async {
    final Uri uri = Uri.parse("$baseUrl/version_files/update");

    final Map<String, String> queryParams = {
      "algorithm": algorithm.name,
    };

    uri.replace(queryParameters: queryParams);

    final http.Response res = await client.post(
      uri,
      body: json.encode(
        {
          "hashes": hashes,
          "algorithm": algorithm.name,
          "loaders": loaders,
          "game_versions": gameVersions,
        },
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to get version from hash.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    final Map decoded = json.decode(res.body);

    return decoded.values.map((e) => Version.fromMap(e)).toList();
  }
}

enum HashAlgorithm { sha1, sha512 }
