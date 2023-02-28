class DonationPlatform {
  DonationPlatform({
    required this.id,
    required this.platform,
    required this.url,
  });

  String id;
  String platform;
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
