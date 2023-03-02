import "dart:convert";

import 'package:collection/collection.dart';
import "package:modrinth_api/src/core/user/badges.dart";
import "package:modrinth_api/src/core/user/payout.dart";

class User {
  User({
    required this.username,
    this.name,
    this.email,
    required this.bio,
    this.payout,
    required this.id,
    this.githubId,
    required this.avatarUrl,
    required this.created,
    required this.role,
    required this.badges,
  });

  /// The user's username
  final String username;

  /// The user's display name
  final String? name;

  /// The user's email (only your own is ever displayed)
  final String? email;

  /// A description of the user
  final String? bio;

  /// Various data relating to the user's payouts status (you can only see your own)
  final Payout? payout;

  /// The user's id
  final String id;

  /// The user's github id
  final int? githubId;

  /// The user's avatar url
  final String avatarUrl;

  /// The time at which the user was created
  final DateTime created;

  /// The user's role
  final UserRole role;

  // Any badges applicable to this user. These are currently unused and undisplayed, and as such are subject to change
  final Badges badges;

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map["username"]!,
      name: map["name"],
      email: map["email"],
      bio: map["bio"],
      payout: map["payout_data"] != null ? Payout.fromMap(map["payout_data"]) : null,
      id: map["id"]!,
      githubId: map["github_id"],
      avatarUrl: map["avatar_url"]!,
      created: DateTime.tryParse(map["created"]!) ?? DateTime(0),
      role: UserRole.values.firstWhereOrNull((element) => map["role"] == element.name) ?? UserRole.developer,
      badges: Badges(map["badges"]!),
    );
  }

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return "User(username: $username, name: $name)";
  }

  String toLongString() {
    return "User(username: $username, name: $name, email: $email, bio: $bio, payout: $payout, id: $id, githubId: $githubId, avatarUrl: $avatarUrl, created: $created, role: $role, badges: $badges)";
  }
}

enum UserRole { admin, moderator, developer }
