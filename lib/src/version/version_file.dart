import 'package:modrinth_api/src/version/version_hashes.dart';

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
}

enum VersionFileType { required_resource_pack, optional_resource_pack }
