import 'package:unittest/unittest.dart';
import 'package:semver/semver.dart';

void main() {
  test('can instantiate from string', () {
    var tag = '0.1.0';
    var sm = new SemanticVersion.fromString(tag);
    expect(sm.toString(), equals('0.1.0'));
  });

  test('can instantiate from map', () {
    var tag = '0.1.0';
    var data = new Map();
    data['major'] = 0;
    data['minor'] = 1;
    data['patch'] = 0;
    var sm = new SemanticVersion.fromMap(data);
    expect(sm.toString(), equals('0.1.0'));
  });

  test('can instantiate from default constructor', () {
    var tag = '0.1.0';
    var sm = new SemanticVersion(0, 1, 0);
    expect(sm.toString(), equals('0.1.0'));
  });
}
