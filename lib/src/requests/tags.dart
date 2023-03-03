import "dart:convert";

import "package:http/http.dart" as http;
import "package:modrinth_api/src/core/project/donation_platform.dart";
import "package:modrinth_api/src/core/tags/tag_category.dart";
import "package:modrinth_api/src/core/tags/tag_game_version.dart";
import "package:modrinth_api/src/core/tags/tag_license.dart";
import "package:modrinth_api/src/core/tags/tag_loader.dart";
import "package:modrinth_api/src/modrinth.dart";

mixin TagsRequests on IModrinthApi {
  /// Get a list of categories, their icons, and applicable project types
  Future<List<TagCategory>> getCategories() async {
    Uri uri = Uri.parse("${IModrinthApi.baseUrl}/tag/category");

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get categories.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    final List decoded = json.decode(res.body);

    return decoded.map((e) => TagCategory.fromMap(e)).toList();
  }

  /// Get a list of loaders, their icons, and supported project types
  Future<List<TagLoader>> getLoaders() async {
    Uri uri = Uri.parse("${IModrinthApi.baseUrl}/tag/loader");

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get loaders.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    final List decoded = json.decode(res.body);

    return decoded.map((e) => TagLoader.fromMap(e)).toList();
  }

  /// Get a list of game versions and information about them
  Future<List<TagGameVersion>> getGameVersions() async {
    Uri uri = Uri.parse("${IModrinthApi.baseUrl}/tag/game_version");

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get game versions.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    final List decoded = json.decode(res.body);

    return decoded.map((e) => TagGameVersion.fromMap(e)).toList();
  }

  /// Get a list of licenses and information about them
  Future<List<TagLicense>> getLicenses() async {
    Uri uri = Uri.parse("${IModrinthApi.baseUrl}/tag/license");

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get licenses.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    final List decoded = json.decode(res.body);

    return decoded.map((e) => TagLicense.fromMap(e)).toList();
  }

  /// Get a list of donation platforms and information about them
  Future<List<DonationPlatform>> getDonationPlatforms() async {
    Uri uri = Uri.parse("${IModrinthApi.baseUrl}/tag/donation_platform");

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get donation platforms.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    final List decoded = json.decode(res.body);

    return decoded.map((e) => DonationPlatform.fromMap(e)).toList();
  }

  /// Get a list of valid report types
  Future<List<String>> getReportTypes() async {
    Uri uri = Uri.parse("${IModrinthApi.baseUrl}/tag/report_type");

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get report types.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    return json.decode(res.body);
  }
}
