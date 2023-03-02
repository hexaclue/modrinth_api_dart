/// A list of images that have been uploaded to a project's gallery.
class GalleryImage {
  GalleryImage({
    required this.url,
    required this.featured,
    this.title,
    this.description,
    required this.created,
    required this.ordering,
  });

  /// The URL of the gallery image
  String url;

  /// Whether the image is featured in the gallery
  bool featured;

  /// The title of the gallery image
  String? title;

  /// The description of the gallery image
  String? description;

  /// The date and time the gallery image was created
  DateTime created;

  /// The order of the gallery image. Gallery images are sorted by this field and then alphabetically by title.
  int ordering;

  factory GalleryImage.fromMap(Map<String, dynamic> map) => GalleryImage(
        url: map["url"]!,
        featured: map["featured"]!,
        title: map["title"],
        description: map["description"],
        created: DateTime.parse(map["created"]!),
        ordering: map["ordering"]!,
      );

  @override
  String toString() {
    return "GalleryImage(url: $url)";
  }
}
