import "dart:convert";

/// A platform on which creators can be supported.
class TagDonationPlatform {
  TagDonationPlatform({
    required this.short,
    required this.platform,
  });

  /// The ID of the donation platform
  String short;

  /// The donation platform this link is to
  String platform;

  factory TagDonationPlatform.fromMap(Map<String, dynamic> map) => TagDonationPlatform(
        short: map["short"]!,
        platform: map["platform"]!,
      );

  factory TagDonationPlatform.fromJson(String source) => TagDonationPlatform.fromMap(json.decode(source));
}
