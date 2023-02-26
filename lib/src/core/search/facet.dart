class Facet {
  Facet(this.type, this.value);

  final FacetType type;
  final String value;

  @override
  String toString() {
    return "${type.name}:'$value'";
  }
}

enum FacetType { categories, versions, license, project_type, open_source }
