class Payout {
  Payout({
    required this.balance,
    required this.wallet,
    required this.walletType,
    required this.address,
  });

  /// The payout balance available for the user to withdraw (note, you cannot modify this in a PATCH request)
  final int balance;

  /// The wallet that the user has selected
  final PayoutWallet wallet;

  /// The type of the user's wallet
  final PayoutWalletType walletType;

  /// The user's payout address
  final String address;
}

enum PayoutWallet { paypal, venmo }

enum PayoutWalletType { email, phone, user_handle }
