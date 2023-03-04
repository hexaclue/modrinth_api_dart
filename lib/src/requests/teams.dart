import "dart:convert";

import "package:http/http.dart" as http;
import "package:modrinth_api/src/core/team/team_member.dart";
import "package:modrinth_api/src/modrinth.dart";

mixin TeamsRequests on IModrinthApi {
  /// Gets a project's team members by the id or slug of the project.
  ///
  /// [idOrSlug] is the id or slug of the team. Can **not** be empty.
  Future<List<TeamMember>> getTeamMembersByProject(String idOrSlug) async {
    Uri uri = Uri.parse("$baseUrl/project/$idOrSlug/members");

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get user.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    final List decoded = json.decode(res.body);

    return decoded.map((e) => TeamMember.fromMap(e)).toList();
  }

  /// Gets team members by the id of the team.
  ///
  /// [id] is the id of the team. Can **not** be empty.
  Future<List<TeamMember>> getTeamMembers(String id) async {
    Uri uri = Uri.parse("$baseUrl/team/$id/members");

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get team members.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    final List decoded = json.decode(res.body);

    return decoded.map((e) => TeamMember.fromMap(e)).toList();
  }

  /// Gets team members of multiple teams by the ids of the teams.
  ///
  /// [ids] is the list of ids of the teams. Can **not** be empty.
  ///
  /// Returns a list of lists of team members.
  Future<List<List<TeamMember>>> getMultipleTeamMembers(List<String> ids) async {
    Uri uri = Uri.parse("$baseUrl/teams");

    uri = uri.replace(
      queryParameters: {
        "ids": json.encode(ids),
      },
    );

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get team members.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    final List decoded = json.decode(res.body);

    return decoded.map((e) => (e as List).map((f) => TeamMember.fromMap(f)).toList()).toList();
  }
}
