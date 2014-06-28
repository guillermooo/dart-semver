[![Build Status](https://drone.io/github.com/guillermooo/dart-semver/status.png)](https://drone.io/github.com/guillermooo/dart-semver/latest)

A version parser for tags formed after the [semantic versioning convention][1].

[1]: http://semver.org


### Parsing versions

```dart
import 'package:semver/semver.dart';

// from strings
var sm = new semanticversion.fromstring('0.1.0');

// from maps
var myver = {'major': 10, 'minor': 5, 'patch': 1, build: '200'};
var sm = new semanticversion.frommap(myver);

// directly
var newver = semanticversion(20, 10, 0, pre: 'alpha');
```

### Comparing versions

```dart
import 'package:semver/semver.dart';

var sm1 = new semanticversion.fromstring('0.1.0+200');
var sm2 = new semanticversion.fromstring('0.1.0+400');

assert(sm1 == sm2); // true

var sm3 = new semanticversion.fromstring('0.1.0-alpha');
var sm4 = new semanticversion.fromstring('0.1.0');

assert(sm3 < sm2); // true
```