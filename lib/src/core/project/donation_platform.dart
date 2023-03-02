/// A platform on which creators can be supported.
class DonationPlatform {
  DonationPlatform({
    required this.id,
    required this.platform,
    required this.url,
  });

  /// The ID of the donation platform
  String id;

  /// The donation platform this link is to
  String platform;

  /// The URL of the donation platform and user
  String url;

  factory DonationPlatform.fromMap(Map<String, dynamic> map) => DonationPlatform(
        id: map["id"],
        platform: map["platform"],
        url: map["url"],
      );

  @override
  String toString() {
    return "DonationPlatform(id: $id, platform: $platform, url: $url)";
  }
}
