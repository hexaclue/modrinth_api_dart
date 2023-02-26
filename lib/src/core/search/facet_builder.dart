import "dart:convert";

import "facet.dart";

/// A builder for creating a facet string.
///
/// Use .and() to add a facet to the list of facets that **must** be matched.
///
/// Use .or() to add a list of facets to the list of facets that **can** be matched.
///
/// Use `.build()` to build the facet string. Note that this is not needed if you are using the functions in this library, and you can just pass the [FacetListBuilder] to the function.
class FacetListBuilder {
  /// If all of the facets in this list are matched, the results will be returned in the searching process.
  ///
  /// Use [and] to add a facet to this list.
  List<Facet> andBlocks = [];

  /// If any of the facets in this list are matched, the results will be returned in the searching process.
  ///
  /// Use [or] to add a list of facets to this list.
  List<List<Facet>> orBlocks = [];

  // FacetBuilder();

  /// When searching, the API will return results that matches this facet.
  void and(Facet facet) {
    andBlocks.add(facet);
  }

  /// When searching, the API will return results that match any of the facets in this list.
  ///
  /// Must contain at least two facets. If you only want to match one facet, use [and] instead.
  void or(List<Facet> facets) {
    orBlocks.add(facets);
  }

  /// Build the facet string for use in the API.
  ///
  /// Returns `null` if no facets have been added.
  String? build() {
    List<List<String>> facets = [
      ...andBlocks.map(
        (e) => [e.toString()],
      )
    ];

    for (final orBlock in orBlocks) {
      facets.add(orBlock.map((e) => e.toString()).toList());
    }

    if (facets.isEmpty) {
      return null;
    }

    return json.encode(facets);
  }

  @override
  String toString() {
    return "FacetListBuilder(andBlocks: ${andBlocks.length}, orBlocks: ${orBlocks.length})";
  }
}
