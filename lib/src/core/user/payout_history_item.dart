/// Item in the history of payouts of a user.
class PayoutHistoryItem {
  PayoutHistoryItem({
    required this.created,
    required this.amount,
    required this.status,
  });

  /// The date of this transaction
  final DateTime created;

  /// The amount of this transaction
  final double amount;

  /// The status of this transaction
  final String status;

  factory PayoutHistoryItem.fromMap(Map<String, dynamic> map) {
    return PayoutHistoryItem(
      created: DateTime.tryParse(map["created"]) ?? DateTime(0),
      amount: map["amount"] is double? ? map["amount"] : double.parse(map["amount"]),
      status: map["status"],
    );
  }
}
