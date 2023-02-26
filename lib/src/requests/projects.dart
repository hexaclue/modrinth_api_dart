import 'package:modrinth_api/src/core/search/facet_builder.dart';
import "package:modrinth_api/src/modrinth.dart";

mixin ProjectsRequests on IModrinthApi {
  /// Search for projects
  ///
  /// [query] is the query to search for. Can be null
  ///
  /// [sort] is the sorting method used for sorting search results. Default is [SortMethod.relevance]
  ///
  /// [facets] is the facets used for filtering search results. Can be null
  Future<void> search({
    String? query,
    SortMethod? sort,
    FacetListBuilder? facets,
  }) async {
    Uri uri = Uri.parse("${IModrinthApi.baseUrl}/search");

    Map<String, String> queryParams = {};

    if (query != null) {
      queryParams["query"] = query;
    }

    if (sort != null) {
      queryParams["sort"] = sort.toString().split(".").last;
    }

    if (facets != null) {
      String? builtFacetList = facets.build();

      if (builtFacetList != null) {
        print(builtFacetList);
        queryParams["facets"] = builtFacetList;
      }
    }

    if (queryParams.isNotEmpty) {
      uri = uri.replace(queryParameters: queryParams);
    }

    print(uri);

    // print(Uri.encodeComponent(query ?? ""));
    // client.get(Uri.parse("${IModrinthApi.baseUrl}/search?query=${"test"}"));
  }
}

enum SortMethod { relevance, downloads, follows, newest, updated }
