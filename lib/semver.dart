library semver;

import 'package:semver/source/tokenizer.dart' show SemanticVersionTokenizer;

class SemanticVersion {
  /*
  * Represents a tag in the semantic version format: http://semver.org/.
  */
  final int major;
  final int minor;
  final int patch;
  final String pre;
  final String build;

  const SemanticVersion(this.major, this.minor, this.patch, [this.pre,
      this.build]);

  factory SemanticVersion.fromMap(Map tag) {
    return new SemanticVersion(tag['major'], tag['minor'], tag['patch'],
      tag['pre'], tag['build']);
  }

  factory SemanticVersion.fromString(String tag) {
    SemanticVersionTokenizer t = new SemanticVersionTokenizer(tag);
    return new SemanticVersion.fromMap(t.tokenize());
  }

  operator ==(SemanticVersion other) {
    return (this.major == other.major && this.minor == other.minor &&
        this.patch == other.patch && this.pre == other.pre &&
        this.build == other.build);
  }

  operator <(SemanticVersion other) {
    if (this.major < other.major) {
      return true;
    }

    if (this.major == other.major) {
      if (this.minor < other.minor) {
        return true;
      } else if (this.minor == other.minor) {
        if (this.patch != other.patch && this.patch < other.patch) {
          return true;
        } else if (this.patch != other.patch) {
          return false;
        }
      }
    }

    print(
      "WARNING: comparing '${this.pre}' and '${other.pre}' as strings!");

    if (this.pre == null && other.pre == null &&
        this.build == null && other.build == null) {
      return false;
    } else if (this.pre == null && other.pre != null) {
      return true;
    } else if (this.pre != null && other.pre == null) {
      return false;
    }

    print(
      "WARNING: comparing '${this.build}' and '${other.build}' as strings!");

    if (this.pre != null && other.pre != null) {
      if (this.pre == other.pre) {
        if (this.build == other.build) {
          return false;
        }
      }
      var sorted = [this.pre, other.pre]..sort();
      return identical(sorted[0], this.pre);
    }

    if (this.build == null && other.build == null) {
      return false;
    } else if (this.build == null && other.build != null) {
      return true;
    } else if (this.build == null && other.build != null) {
      return false;
    }

    var sorted = [this.build, other.build]..sort();
    return identical(sorted[0], this.build);
  }

  operator >(SemanticVersion other) {
    if (this == other || this < other) {
      return false;
    }
    return true;
  }

  operator >=(SemanticVersion other) {
    if (this > other || this == other ) {
      return true;
    }
    return false;
  }

  operator <=(SemanticVersion other) {
    if (this < other || this == other) {
      return true;
    }
    return false;
  }

  @override
  String toString() {
    var version = "${this.major}.${this.minor}.${this.patch}";

    if (this.pre != null) {
        version = "$version-${this.pre}";
    }

    if (this.build != null) {
        version = "$version+${this.build}";
    }

    return version;
  }
}