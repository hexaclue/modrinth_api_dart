import "dart:convert";

import "package:collection/collection.dart";

/// A notification a user may have on their account.
class Notification {
  Notification({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.text,
    required this.link,
    required this.read,
    required this.created,
  });

  /// The id of the notification
  final String id;

  /// The id of the user who received the notification
  final String userId;

  /// The type of notification
  final NotificationType type;

  /// The title of the notification
  final String title;

  /// The body text of the notification
  final String text;

  /// A link to the related project or version
  final String link;

  /// Whether the notification has been read or not
  final bool read;

  /// The time at which the notification was created
  final DateTime created;

  // Actions???

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      id: map["id"]!,
      userId: map["user_id"]!,
      type: NotificationType.values.firstWhereOrNull((element) => map["payout_wallet"] == element.name) ??
          NotificationType.values[0],
      title: map["title"]!,
      text: map["text"]!,
      link: map["link"]!,
      read: map["read"]!,
      created: DateTime.tryParse(map["created"]) ?? DateTime(0),
    );
  }

  factory Notification.fromJson(String source) => Notification.fromMap(json.decode(source));
}

enum NotificationType { project_update, team_invite, status_update }
