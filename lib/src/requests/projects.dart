import 'dart:convert';

import "package:modrinth_api/src/core/search/facet_builder.dart";
import 'package:modrinth_api/src/core/search/search_result.dart';
import "package:modrinth_api/src/modrinth.dart";
import "package:http/http.dart" as http;

mixin ProjectsRequests on IModrinthApi {
  /// Search for projects
  ///
  /// [query] is the query to search for. Can be null
  ///
  /// [sort] is the sorting method used for sorting search results. Default is [SortMethod.relevance]
  ///
  /// [facets] is the list of facets used for filtering search results. Can be null
  ///
  /// [offset] is the offset into the search. Skips this number of results. Default is 0
  ///
  /// [limit] is the number of results returned by the search. Default is 10
  ///
  /// [filters] is a list of filters relating to the properties of a project. Note that using facets is preferred over filters, due to speed. For filter syntax, see https://docs.modrinth.com/docs/tutorials/api_search/#filters
  Future<List<SearchResult>> search({
    String? query,
    FacetListBuilder? facets,
    SortMethod? sort,
    int? offset,
    int? limit,
    String? filters,
  }) async {
    Uri uri = Uri.parse("${IModrinthApi.baseUrl}/search");

    Map<String, String> queryParams = {};

    if (query != null) {
      queryParams["query"] = query;
    }

    if (facets != null) {
      String? builtFacetList = facets.build();

      if (builtFacetList != null) {
        queryParams["facets"] = builtFacetList;
      }
    }

    if (sort != null) {
      queryParams["sort"] = sort.name;
    }

    if (offset != null) {
      queryParams["offset"] = offset.toString();
    }

    if (limit != null) {
      queryParams["limit"] = limit.toString();
    }

    if (filters != null) {
      queryParams["filters"] = filters;
    }

    if (queryParams.isNotEmpty) {
      uri = uri.replace(queryParameters: queryParams);
    }

    http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to search for projects.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    var decoded = (json.decode(res.body) as Map)["hits"] as List;

    return decoded.map((e) => SearchResult.fromMap(e)).toList();
  }
}

enum SortMethod { relevance, downloads, follows, newest, updated }
