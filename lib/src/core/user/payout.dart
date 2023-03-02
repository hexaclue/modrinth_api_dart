import "dart:convert";

import "package:collection/collection.dart";

/// A [User]'s payout information.
class Payout {
  Payout({
    required this.balance,
    required this.wallet,
    required this.walletType,
    required this.address,
  });

  /// The payout balance available for the user to withdraw (note, you cannot modify this in a PATCH request)
  final double? balance;

  /// The wallet that the user has selected
  final PayoutWallet? wallet;

  /// The type of the user's wallet
  final PayoutWalletType? walletType;

  /// The user's payout address
  final String? address;

  factory Payout.fromMap(Map<String, dynamic> map) {
    return Payout(
      balance: map["balance"] is double? ? map["balance"] : double.parse(map["balance"]),
      wallet: PayoutWallet.values.firstWhereOrNull((element) => map["payout_wallet"] == element.name),
      walletType: PayoutWalletType.values.firstWhereOrNull((element) => map["payout_wallet_type"] == element.name),
      address: map["payout_address"],
    );
  }

  factory Payout.fromJson(String source) => Payout.fromMap(json.decode(source));

  /// Returns a [String] representation of this object.
  ///
  /// Note that this has [balance] and [address] censored for privacy reasons. They are present in the actual [Payout] instance.
  @override
  String toString() => "Payout("
      "balance: ${(balance ?? 0) != 0 ? "<not zero>" : "0"}, "
      "wallet: $wallet, "
      "walletType: $walletType, "
      "address: ${address == null ? "null" : "<not null>"})";
}

enum PayoutWallet { paypal, venmo }

enum PayoutWalletType { email, phone, user_handle }
