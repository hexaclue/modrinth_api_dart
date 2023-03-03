import "package:http/http.dart" as http;
import "package:modrinth_api/src/core/instance_statistics.dart";
import "package:modrinth_api/src/modrinth.dart";

mixin MiscellaneousRequests on IModrinthApi {
  /// Get this Modrinth instance's statistics
  Future<InstanceStatistics> getInstanceStatistics() async {
    Uri uri = Uri.parse("${IModrinthApi.baseUrl}/statistics");

    final http.Response res = await client.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Failed to get instance statistics.\nStatus code ${res.statusCode}.\nBody: ${res.body}");
    }

    return InstanceStatistics.fromJson(res.body);
  }
}
