import "package:modrinth_api/src/core/team/team_permissions_constants.dart";

/// Team permissions applicable to this user.
class TeamPermissions {
  const TeamPermissions(this.raw);

  final int raw;

  bool get uploadVersion => (raw & TeamPermissionsConstants.uploadVersion) != 0;
  bool get deleteVersion => (raw & TeamPermissionsConstants.deleteVersion) != 0;
  bool get editDetails => (raw & TeamPermissionsConstants.editDetails) != 0;
  bool get editBody => (raw & TeamPermissionsConstants.editBody) != 0;
  bool get manageInvites => (raw & TeamPermissionsConstants.manageInvites) != 0;
  bool get removeMember => (raw & TeamPermissionsConstants.removeMember) != 0;
  bool get editMember => (raw & TeamPermissionsConstants.editMember) != 0;
  bool get deleteProject => (raw & TeamPermissionsConstants.deleteProject) != 0;
  bool get viewAnalytics => (raw & TeamPermissionsConstants.viewAnalytics) != 0;
  bool get viewPayouts => (raw & TeamPermissionsConstants.viewPayouts) != 0;

  @override
  String toString() {
    List<String> permissions = [
      if (uploadVersion) "uploadVersion",
      if (deleteVersion) "deleteVersion",
      if (editDetails) "editDetails",
      if (editBody) "editBody",
      if (manageInvites) "manageInvites",
      if (removeMember) "removeMember",
      if (editMember) "editMember",
      if (deleteProject) "deleteProject",
      if (viewAnalytics) "viewAnalytics",
      if (viewPayouts) "viewPayouts",
    ];

    return "TeamPermissions(raw: $raw; ${permissions.join(", ")})";
  }
}
