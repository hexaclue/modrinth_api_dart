import "dart:convert";

import "package:http/http.dart" as http;
import "package:modrinth_api/src/core/project/project.dart";
import "package:modrinth_api/src/core/project/project_dependency.dart";
import "package:modrinth_api/src/core/search/facet_builder.dart";
import "package:modrinth_api/src/core/search/search_result.dart";
import "package:modrinth_api/src/modrinth.dart";

mixin ProjectsRequests on IModrinthApi {
  /// Search for projects.
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

    final Map<String, String> queryParams = {};

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

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to search for projects.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    final decoded = (json.decode(res.body) as Map)["hits"] as List;

    return decoded.map((e) => SearchResult.fromMap(e)).toList();
  }

  /// Get a project by its id or slug.
  ///
  /// [idOrSlug] is the id or slug of the project to get. Can **not** be empty.
  Future<Project> getProject(String idOrSlug) async {
    final Uri uri = Uri.parse("${IModrinthApi.baseUrl}/project/$idOrSlug");

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get project.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    return Project.fromMap(json.decode(res.body));
  }

  /// Get multiple projects by their ids.
  ///
  /// Note that you can not use slugs here.
  Future<List<Project>> getMultipleProjects(List<String> ids) async {
    Uri uri = Uri.parse("${IModrinthApi.baseUrl}/projects");

    uri = uri.replace(
      queryParameters: {
        "ids": json.encode(ids),
      },
    );

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get projects.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    final List decoded = json.decode(res.body);

    return decoded.map((e) => Project.fromMap(e)).toList();
  }

  /// Get [count] random projects.
  ///
  /// Default [count] is 10, maximum is 100.
  ///
  /// Note: list may not be of size [count], as the API itself filters out projects that are not (publically) searchable.
  Future<List<Project>> getRandomProjects([int count = 10]) async {
    Uri uri = Uri.parse("${IModrinthApi.baseUrl}/projects_random");

    uri = uri.replace(
      queryParameters: {
        "count": "$count",
      },
    );

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get $count random projects.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    final List decoded = json.decode(res.body);

    return decoded.map((e) => Project.fromMap(e)).toList();
  }

  /// Check if a project exists.
  ///
  /// [idOrSlug] is the id or slug of the project to get. Can **not** be empty.
  ///
  /// Note: this function does not throw if the request returns 404, as opposed to all other functions.
  Future<bool> checkProjectExists(String idOrSlug) async {
    final Uri uri = Uri.parse("${IModrinthApi.baseUrl}/project/$idOrSlug/check");

    final http.Response res = await client.get(uri);

    return res.statusCode == 200;
  }

  /// Get dependencies of a project.
  ///
  /// [idOrSlug] is the id or slug of the project to get. Can **not** be empty.
  Future<ProjectDependencies> getProjectDependencies(String idOrSlug) async {
    final Uri uri = Uri.parse("${IModrinthApi.baseUrl}/project/$idOrSlug/dependencies");

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get project dependencies.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    return ProjectDependencies.fromJson(res.body);
  }
}

enum SortMethod { relevance, downloads, follows, newest, updated }
