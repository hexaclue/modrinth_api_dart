class RateLimiter {
  static int limit = 300;

  static int remaining = 300;

  static DateTime reset = DateTime(0);

  static int scheduled = 0;

  static void updateHeaders(Map<String, String> headers) {
    limit = int.parse(headers["x-ratelimit-limit"]!);
    remaining = int.parse(headers["x-ratelimit-remaining"]!);
    reset = DateTime.now().add(
      Duration(
        seconds: (int.tryParse(headers["x-ratelimit-reset"] ?? "") ?? 0) + 1,
      ),
    );
  }

  static Future<void> wait() async {
    scheduled++;

    if (scheduled > remaining) {
      final diff = reset.difference(DateTime.now());

      if (diff.inSeconds > 0) {
        print("[ModrinthApi/W] API rate limit reached! Waiting for $diff for this request.");

        await Future.delayed(
          diff + Duration(milliseconds: ((scheduled - 1) * (60 / limit) * 1000).toInt()),
        );
      }
    }

    scheduled--;
  }
}
