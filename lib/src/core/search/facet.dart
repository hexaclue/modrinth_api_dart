/// Facet is a filter that can be applied to a search query.
///
/// Be aware that the [value] cannot contain `'` or `"` characters.
class Facet {
  Facet(this.type, this.value) {
    if (value.contains("'") || value.contains("\"")) {
      throw ArgumentError.value(value, "value", "Cannot contain ' or \"");
    }
  }

  final FacetType type;
  final String value;

  @override
  String toString() {
    return "${type.name}:'$value'";
  }
}

enum FacetType { categories, versions, license, project_type, open_source }
