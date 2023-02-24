/// A list of images that have been uploaded to the project's gallery
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
}
