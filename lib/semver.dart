// Copyright (c) 2015, Guillermo López-Anglada. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// A parser for version tags following the semantic versioning scheme.
library semver;

import './src/tokenizer.dart' show tokenize;

/// Represents a tag in the semantic version format: http://semver.org/.
class SemanticVersion extends Object with Comparable {
  final int major;
  final int minor;
  final int patch;
  final String pre;
  final String build;

  SemanticVersion(this.major, this.minor, this.patch, [this.pre,
      this.build]);

  factory SemanticVersion.fromMap(Map tag) {
    return new SemanticVersion(tag['major'], tag['minor'], tag['patch'],
      tag['pre'], tag['build']);
  }

  factory SemanticVersion.fromString(String tag) {
    return new SemanticVersion.fromMap(tokenize(tag));
  }

  operator ==(SemanticVersion other) {
    return (this.major == other.major && this.minor == other.minor &&
        this.patch == other.patch && this.pre == other.pre);
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

    if (this.pre == null && other.pre == null) {
      return false;
    } else if (this.pre == null && other.pre != null) {
      return false;
    } else if (this.pre != null && other.pre == null) {
      return true;
    }

    if (this.pre == other.pre) {
        return false;
    }

    var isSmaller = comparePreReleasePart(splitPreReleaseParts(this.pre),
        splitPreReleaseParts(other.pre));
    return isSmaller == -1 ? true : false;
  }

  operator >(SemanticVersion other) {
    return !(this == other || this < other);
  }

  operator >=(SemanticVersion other) {
    return (this > other || this == other );
  }

  operator <=(SemanticVersion other) {
    return (this < other || this == other);
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

  int compareTo(SemanticVersion other) {
    if (this < other) return -1;
    else if (this > other) return 1;
    else return 0;
  }
}

int comparePreReleasePart(List a, List b) {
  for(var i = 0; i < a.length; i++) {
    if (i >= b.length) {
      return 1;
    }

    var elemA = a[i];
    var elemB = b[i];

    // In Semver, integers < strings.
    if (elemA is String && elemB is !String) {
      return 1;
    } else if (elemA is !String && elemB is String) {
      return -1;
    // Compare ints normally.
    } else if (elemA is int && elemB is int) {
      if (elemA < elemB) {
        return -1;
      } else if (elemA > elemB) {
        return 1;
      }
    } else {
      // Compare strings.
      switch (compareStrings(elemA, elemB)) {
        case -1:
          return -1;
        case 1:
          return 1;
        default:
      }
    }
  }

  if (a.length == b.length) {
    return 0;
  }

  return a.length > b.length ? 1 : -1;
}

List splitPreReleaseParts(String thing) {
  return thing.split('.').map((element) {
    try {
      return int.parse(element, radix: 10);
    } catch (FormatException) {
      return element;
    }
  }).toList(growable:false);
}

int compareStrings(String a, String b) {
  if (a == b) {
    return 0;
  }
  var sorted = [a, b]..sort();
  return identical(sorted[0], a) ? -1 : 1;
}
