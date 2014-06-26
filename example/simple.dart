import 'package:semver/semver.dart';

// instantiating a version
var version = new SemanticVersion(0, 1, 0, 'alpha.01', 'test.200');
var asString = version.toString(); // ==> 0.1.0-alpha.01+test.200

// other ways of instantiating versions
var anotherVersion = new SemanticVersion.fromString('0.1.0-beta');
var preReleaseTag = anotherVersion.pre; // ==> 'beta'

Map data = {
  "major": 0,
  "minor": 1,
  "patch": 1
};

var yetAnotherVersion = new SemanticVersion.fromMap(data);

// comparing versions
var isSmaller = (version < yetAnotherVersion ); // true