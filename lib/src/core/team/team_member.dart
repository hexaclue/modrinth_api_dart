import "dart:convert";

import "package:modrinth_api/src/core/team/team_permissions.dart";
import "package:modrinth_api/src/core/user/user.dart";

/// A member in a team.
class TeamMember {
  TeamMember({
    required this.teamId,
    required this.user,
    required this.role,
    required this.permissions,
    required this.accepted,
    required this.payoutSplit,
    required this.ordering,
  });

  /// The ID of the team this team member is a member of
  final String teamId;

  /// The ID of the user that is a member of the team
  final User user;

  /// The user's role on the team
  final String role;

  /// The user's permissions in bitfield format (requires authorization to view)
  final TeamPermissions? permissions;

  /// Whether or not the user has accepted to be on the team (requires authorization to view)
  final bool accepted;

  /// The split of payouts going to this user. The proportion of payouts they get is their split divided by the sum of the splits of all members.
  final int? payoutSplit;

  /// The order of the team member.
  final int ordering;

  factory TeamMember.fromMap(Map<String, dynamic> map) {
    return TeamMember(
      teamId: map["team_id"]!,
      user: User.fromMap(map["user"]!),
      role: map["role"]!,
      permissions: map["permissions"] != null ? TeamPermissions(map["permissions"]) : null,
      accepted: map["accepted"]!,
      payoutSplit: map["payouts_split"],
      ordering: map["ordering"]!,
    );
  }

  factory TeamMember.fromJson(String source) => TeamMember.fromMap(json.decode(source));

  @override
  String toString() {
    return "TeamMember(teamId: $teamId, user: $user)";
  }

  String toLongString() {
    return "TeamMember(teamId: $teamId, user: $user, role: $role, permissions: $permissions, accepted: $accepted, payoutSplit: $payoutSplit, ordering: $ordering)";
  }
}
