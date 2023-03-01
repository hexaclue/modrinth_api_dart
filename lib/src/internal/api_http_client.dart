import "package:http/http.dart" as http;

class ApiHttpClient extends http.BaseClient {
  final String userAgent;
  final http.Client _inner;
  final String? apiKey;

  ApiHttpClient(this.userAgent, this._inner, [this.apiKey]);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers["user-agent"] = userAgent;

    if (apiKey != null) {
      request.headers["Authorization"] = apiKey!;
    }

    return _inner.send(request);
  }

  @override
  void close() {
    _inner.close();
  }
}
