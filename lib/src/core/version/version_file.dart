import "dart:convert";

import "package:collection/collection.dart";
import "package:modrinth_api/src/core/version/version_hashes.dart";

class VersionFile {
  VersionFile({
    required this.hashes,
    required this.url,
    required this.fileName,
    required this.primary,
    required this.size,
    this.type,
  });

  /// Hashes of the file
  final VersionHashes hashes;

  /// A direct link to the file
  final String url;

  /// The name of the file
  final String fileName;

  final bool primary;

  /// The size of the file in bytes
  final int size;

  /// The type of the additional file, used mainly for adding resource packs to datapacks
  final VersionFileType? type;

  factory VersionFile.fromMap(Map<String, dynamic> map) {
    return VersionFile(
      hashes: VersionHashes.fromMap(map["hashes"]!),
      url: map["url"]!,
      fileName: map["filename"]!,
      primary: map["primary"] ?? false,
      size: map["size"]!,
      type: VersionFileType.values.firstWhereOrNull((element) => map["file_type"] == element.name),
    );
  }

  factory VersionFile.fromJson(String source) => VersionFile.fromMap(json.decode(source));
}

enum VersionFileType { required_resource_pack, optional_resource_pack }
