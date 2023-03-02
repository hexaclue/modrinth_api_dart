import "package:modrinth_api/src/core/user/badges_constants.dart";

/// Badges applicable to a user. These are currently unused and undisplayed, and as such are subject to change
class Badges {
  const Badges(this.raw);

  final int raw;

  bool get earlyModpackAdopter => (raw & BadgesConstants.earlyModpackAdopter) != 0;
  bool get earlyRespackAdopter => (raw & BadgesConstants.earlyRespackAdopter) != 0;
  bool get earlyPluginAdopter => (raw & BadgesConstants.earlyPluginAdopter) != 0;
  bool get alphaTester => (raw & BadgesConstants.alphaTester) != 0;
  bool get contributor => (raw & BadgesConstants.contributor) != 0;
  bool get translator => (raw & BadgesConstants.translator) != 0;

  @override
  String toString() {
    List<String> badges = [];
    if (earlyModpackAdopter) badges.add("earlyModpackAdopter");
    if (earlyRespackAdopter) badges.add("earlyRespackAdopter");
    if (earlyPluginAdopter) badges.add("earlyPluginAdopter");
    if (alphaTester) badges.add("alphaTester");
    if (contributor) badges.add("contributor");
    if (translator) badges.add("translator");

    return "Badges(raw: $raw; ${badges.join(", ")})";
  }
}
