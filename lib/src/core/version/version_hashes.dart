import "dart:convert";

/// File hashes that are used to verify the integrity of or search for a version file.
class VersionHashes {
  VersionHashes({
    required this.sha1,
    required this.sha512,
  });

  final String sha1;
  final String sha512;

  factory VersionHashes.fromMap(Map<String, dynamic> map) {
    return VersionHashes(
      sha1: map["sha1"]!,
      sha512: map["sha512"]!,
    );
  }

  factory VersionHashes.fromJson(String source) => VersionHashes.fromMap(json.decode(source));
}
