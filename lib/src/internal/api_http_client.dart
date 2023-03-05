import "package:http/http.dart" as http;
import "package:modrinth_api/src/internal/rate_limiter.dart";

class ApiHttpClient extends http.BaseClient {
  final String userAgent;
  final http.Client _inner;
  final String? apiKey;

  ApiHttpClient(this.userAgent, this._inner, [this.apiKey]);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    await RateLimiter.wait();

    request.headers["user-agent"] = userAgent;

    if (apiKey != null) {
      request.headers["Authorization"] = apiKey!;
    }

    Future<http.StreamedResponse> sent = _inner.send(request);

    sent.then((value) {
      RateLimiter.updateHeaders(value.headers);
    });

    return sent;
  }

  @override
  void close() {
    _inner.close();
  }
}
