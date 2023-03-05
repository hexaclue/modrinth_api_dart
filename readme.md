# Modrinth API for Dart
Unofficial package for interacting with the Modrinth API, written in pure Dart!

This package currently targets Labrinth version `2.7.0` / `3b22f59`.

<br>

## Features
Feature                                        | Support
-----------------------------------------------|------------------------
Search facets                                  | ✅
Alternative Modrinth instance                  | ✅
Get a version by a file hash                   | ✅
Get statistics about the Modrinth instance     | ✅
Automatic rate limiting                        | ✅
Any requests that make changes to the database | ❌🕒: planned for v1.0.0

> 🌐 Note: this library assumes an internet connection is available. If there is no connection available, the [underlying http library](https://pub.dev/packages/http) will throw.

<br>

## Early access
As this package is still in a v0 phase, breaking changes could happen at any time.

For example, currently, most of the functions throw when something is not found. For most of these functions, that makes sense, but for some, where you don't have a clear "path" to take (clear path: e.g. search --> project id --> `getProject()`  --> version ids --> `getVersion()`), it also throws, instead of returning a null value. I would like to change that, but the foundation of the functions has been laid, and so using them should work with just a bit of finicking around.

<br>

## Getting started
Install the library into your project like so, in your terminal:
```sh
dart pub add modrinth_api
```

Before using the API, import and then initialize the API:

```dart
import "package:modrinth_api/modrinth_api.dart";

void main() async {
  final api = ModrinthApi(project: "my_test_project");
}
```

> Note that you ***have to*** put in a name for your project (even better: insert your (GitHub) username as well). This makes it easier for the developers of the API to see who is using this package, might something go wrong with rate limiting or the content which is uploaded.

If you have an API key, you can specify it as such:

```dart
final api = ModrinthApi(
  project: "my_test_project",
  apiKey: "my_api_key",
);
```

Adding an API key allows you to access functions such as `getAuthenticatedUser`, `getUserNotifications`, `getUserFollowedProjects` and `getUserPayoutHistory`.

Might you want to use the staging API server - which is perfect for debugging & testing purposes - or just use another Modrinth instance, you can specify a custom `baseUrl` in the constructor like so:

```dart
final api = ModrinthApi(
  project: "my_test_project",
  baseUrl: "https://staging-api.modrinth.com/v2",
);
```

Be sure to also dispose of your `ModrinthApi` instance once you're done using it, to prevent hangs even though your code is done running.

```dart
api.dispose();
```

<br>

## Usage
### Searching for projects
Searching can be done with facets. How they work exactly is explained in the [Labrinth docs](https://docs.modrinth.com/docs/tutorials/api_search/#facets).

Example for searching for only mods:

```dart
api.search(
  facets: FacetListBuilder()
    ..and(
      Facet(FacetType.project_type, "mod"),
    ),
);
```

As such, you can also use `or()` to add multiple facets to filter for any of the provided facets.

Example for searching for any project that is *definitely* a mod (`and()`) and could be targeting version 1.19 *or* 1.19.1 (`or()`), and limit the amount of results to 5.

```dart
final quiteExact = await api.search(
  facets: FacetListBuilder()
    ..and(
      Facet(FacetType.project_type, "mod"),
    )
    ..or(
      [
        Facet(FacetType.versions, "1.19"),
        Facet(FacetType.versions, "1.19.1"),
      ],
    ),
  limit: 5,
);
```

<br>

### Get a project by its id or slug
```dart
final exactProject = await api.getProject("P7dR8mSH");
// ...Or:
final exactProject = await api.getProject("fabric-api");
```

<br>

### Get a version by its id
```dart
final exactVersion = await api.getVersion("nOI7bsDO");
```

> Note: you *cannot* use slugs here, as versions don't have slugs.

<br>

### Get a version by a file hash
Note that calculating a file hash requires a library, such as [crypto](https://pub.dev/packages/crypto), as used in the following example:

```dart
import "dart:io";
import "package:crypto/crypto.dart";
import "package:modrinth_api/modrinth_api.dart";

void main() async {
  final api = ModrinthApi(project: "my_test_project");

  final File f = File("my_mod_jar.jar");

  final List<int> input = await f.readAsBytes();

  final String sha = sha1.convert(input).toString();

  final Version foundVersion = await api.getVersionFromHash(sha);
}
```

<br>

### ...and many more functions!
There's many functions in this library, and they are pretty straight-forward to use, in my opinion. Might you need some additional documentation or come across a bug, feel free to open an issue on [the repository](https://github.com/hihiqy1/modrinth_api_dart)!

<br>

## Credits
Huge credits to the Labrinth team for writing [their API docs](https://docs.modrinth.com/api-spec)! Without the docs, this package would be near-impossible to make.

<br>

## License
This library is licensed under the Apache License 2.0