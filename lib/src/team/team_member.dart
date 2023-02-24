import 'package:modrinth_api/src/team/team_permissions.dart';
import 'package:modrinth_api/src/user/user.dart';

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
  final TeamPermissions permissions;

  /// Whether or not the user has accepted to be on the team (requires authorization to view)
  final bool accepted;

  /// The split of payouts going to this user. The proportion of payouts they get is their split divided by the sum of the splits of all members.
  final int payoutSplit;

  /// The order of the team member.
  final int ordering;
}
