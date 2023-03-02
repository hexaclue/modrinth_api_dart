import "dart:convert";

import "package:http/http.dart" as http;
import "package:modrinth_api/src/core/project/project.dart";
import "package:modrinth_api/src/core/user/notification.dart";
import "package:modrinth_api/src/core/user/payout_history.dart";
import "package:modrinth_api/src/core/user/user.dart";
import "package:modrinth_api/src/modrinth.dart";

mixin UsersRequests on IModrinthApi {
  /// Gets a user by their id or username
  ///
  /// [idOrUsername] is the id or username of the user. Can **not** be empty.
  Future<User> getUser(String idOrUsername) async {
    Uri uri = Uri.parse("${IModrinthApi.baseUrl}/user/$idOrUsername");

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get user.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    return User.fromJson(res.body);
  }

  /// Gets the currently authenticated user
  ///
  /// Requires an API key.
  Future<User> getAuthenticatedUser() async {
    if (apiKey == null) {
      throw Exception("No API key provided @ getAuthenticatedUser");
    }

    Uri uri = Uri.parse("${IModrinthApi.baseUrl}/user");

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get authenticated user.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    return User.fromMap(json.decode(res.body));
  }

  /// Get multiple users by their ids
  ///
  /// [ids] is a list of ids of the users. Can **not** be empty.
  ///
  /// Note that you can not use slugs here.
  Future<List<User>> getMultipleUsers(List<String> ids) async {
    Uri uri = Uri.parse("${IModrinthApi.baseUrl}/users");

    uri = uri.replace(
      queryParameters: {
        "ids": json.encode(ids),
      },
    );

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get users.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    final List decoded = json.decode(res.body);

    return decoded.map((e) => User.fromMap(e)).toList();
  }

  /// Get a user's projects
  ///
  /// [idOrUsername] is the id or username of the user. Can **not** be empty.
  Future<List<Project>> getUserProjects(String idOrUsername) async {
    Uri uri = Uri.parse("${IModrinthApi.baseUrl}/user/$idOrUsername/projects");

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get projects for user.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    final List decoded = json.decode(res.body);

    return decoded.map((e) => Project.fromMap(e)).toList();
  }

  /// Get a user's notifications
  ///
  /// [idOrUsername] is the id or username of the user. Can **not** be empty.
  ///
  /// Requires an API key.
  Future<List<Notification>> getUserNotifications(String idOrUsername) async {
    if (apiKey == null) {
      throw Exception("No API key provided @ getUserNotifications");
    }

    Uri uri = Uri.parse("${IModrinthApi.baseUrl}/user/$idOrUsername/notifications");

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get notifications for user.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    final List decoded = json.decode(res.body);

    return decoded.map((e) => Notification.fromMap(e)).toList();
  }

  /// Get a user's followed projects
  ///
  /// [idOrUsername] is the id or username of the user. Can **not** be empty.
  ///
  /// Requires an API key.
  Future<List<Project>> getUserFollowedProjects(String idOrUsername) async {
    if (apiKey == null) {
      throw Exception("No API key provided @ getUserFollowedProjects");
    }

    Uri uri = Uri.parse("${IModrinthApi.baseUrl}/user/$idOrUsername/follows");

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get followed projects for user.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    final List decoded = json.decode(res.body);

    return decoded.map((e) => Project.fromMap(e)).toList();
  }

  /// Get a user's payout history
  ///
  /// [idOrUsername] is the id or username of the user. Can **not** be empty.
  ///
  /// Requires an API key.
  Future<PayoutHistory> getUserPayoutHistory(String idOrUsername) async {
    if (apiKey == null) {
      throw Exception("No API key provided @ getUserPayoutHistory");
    }

    final Uri uri = Uri.parse("${IModrinthApi.baseUrl}/user/$idOrUsername/payouts");

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get payout history for user.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    return PayoutHistory.fromJson(res.body);
  }
}
