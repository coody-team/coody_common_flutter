import 'package:package_info_plus/package_info_plus.dart';

class AppVersionChecker {
  AppVersionChecker({required this.minVersion});

  final Version minVersion;

  Version? _current;

  Future<Version> getCurrentVersion() async {
    if (_current != null) return _current!;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return _current ??= Version(packageInfo.version);
  }

  Future<bool> isOutdated() async {
    final current = await getCurrentVersion();

    return current.compareTo(minVersion) < 0;
  }
}

class Version implements Comparable<Version> {
  late final int major;
  late final int minor;
  late final int patch;

  Version(String v) {
    final splitted = v.split('.');
    major = int.parse(splitted[0]);
    minor = int.parse(splitted[1]);
    patch = int.parse(splitted[2]);
  }

  @override
  int get hashCode => '$major$minor$patch'.hashCode;

  @override
  bool operator ==(covariant Version other) => compareTo(other) == 0;

  @override
  int compareTo(Version other) {
    if (major < other.major) return -1;
    if (major > other.major) return 1;
    if (minor < other.minor) return -1;
    if (minor > other.minor) return 1;
    if (patch < other.patch) return -1;
    if (patch > other.patch) return 1;
    return 0;
  }

  @override
  String toString() => '$major.$minor.$patch';
}
