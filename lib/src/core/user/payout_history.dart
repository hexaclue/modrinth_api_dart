import "dart:convert";

import "package:modrinth_api/src/core/user/payout_history_item.dart";

class PayoutHistory {
  PayoutHistory({
    this.allTime,
    this.lastMonth,
    required this.payouts,
  });

  /// The all-time balance accrued by this user
  final double? allTime;

  /// The amount made by the user in the previous 30 days
  final double? lastMonth;

  /// A history of all of the user's past transactions
  final List<PayoutHistoryItem> payouts;

  factory PayoutHistory.fromMap(Map<String, dynamic> map) {
    return PayoutHistory(
      allTime: map["all_time"] is double? ? map["all_time"] : double.parse(map["all_time"]),
      lastMonth: map["last_month"] is double? ? map["last_month"] : double.parse(map["last_month"]),
      payouts: List<PayoutHistoryItem>.from((map["payouts"]! as List).map((x) => PayoutHistoryItem.fromMap(x))),
    );
  }

  factory PayoutHistory.fromJson(String source) => PayoutHistory.fromMap(json.decode(source));

  @override
  String toString() {
    return "PayoutHistory("
        "allTime: ${(allTime ?? 0) != 0 ? "<not zero>" : allTime}, "
        "lastMonth: ${(lastMonth ?? 0) != 0 ? "<not zero>" : lastMonth}, "
        "payouts: ${payouts.length})";
  }
}
