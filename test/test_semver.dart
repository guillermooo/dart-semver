import 'package:unittest/unittest.dart';
import 'package:semver/semver.dart';

void main() {
  test('can instantiate from string', () {
    var sm = new SemanticVersion.fromString('0.1.0');
    expect(sm.toString(), equals('0.1.0'));
  });

  test('can instantiate from map', () {
    var data = new Map();
    data['major'] = 0;
    data['minor'] = 1;
    data['patch'] = 0;
    var sm = new SemanticVersion.fromMap(data);
    expect(sm.toString(), equals('0.1.0'));
  });

  test('can instantiate from default constructor', () {
    var sm = new SemanticVersion(0, 1, 0);
    expect(sm.toString(), equals('0.1.0'));
  });

  // comparison ops
  test('can detect identical versions', () {
    var sm = new SemanticVersion(0, 1, 0);
    var sm2 = new SemanticVersion(0, 1, 0);
    expect(sm == sm2, equals(true));
  });

  test('can detect identical complex versions (pre-release)', () {
    var sm = new SemanticVersion(0, 1, 0, 'alpha.10');
    var sm2 = new SemanticVersion(0, 1, 0, 'alpha.10');
    expect(sm == sm2, equals(true));
  });

  test('can detect lesser version based on major component', () {
    var sm = new SemanticVersion(0, 0, 0);
    var sm2 = new SemanticVersion(1, 0, 0);
    expect(sm < sm2, equals(true));
  });

  test('can detect lesser version based on minor component', () {
    var sm = new SemanticVersion(0, 0, 0);
    var sm2 = new SemanticVersion(0, 1, 0);
    expect(sm < sm2, equals(true));
  });

  test('can detect lesser version based on patch component', () {
    var sm = new SemanticVersion(0, 0, 0);
    var sm2 = new SemanticVersion(0, 0, 1);
    expect(sm < sm2, equals(true));
  });

  test('pre-release part makes version smaller', () {
    var sm = new SemanticVersion(0, 0, 0);
    var sm2 = new SemanticVersion(0, 0, 0, 'alpha');
    expect(sm < sm2, equals(false));
  });

  test('absence/presence of build component does not affect test', () {
    var sm = new SemanticVersion(0, 0, 0);
    var sm2 = new SemanticVersion(0, 0, 0, null, '20201010');
    expect(sm == sm2, equals(true));
  });

  test('checking for lesser version fails based on major component', () {
    var sm = new SemanticVersion(1, 0, 0);
    var sm2 = new SemanticVersion(0, 0, 0);
    expect(sm < sm2, equals(false));
  });

  test('checking for lesser version fails based on minor component', () {
    var sm = new SemanticVersion(0, 1, 0);
    var sm2 = new SemanticVersion(0, 0, 0);
    expect(sm < sm2, equals(false));
  });

  test('checking for lesser version fails based on patch component', () {
    var sm = new SemanticVersion(0, 1, 0);
    var sm2 = new SemanticVersion(0, 0, 0);
    expect(sm < sm2, equals(false));
  });

  test('can detect lesser version based on pre-release component', () {
    var sm = new SemanticVersion(0, 0, 0, 'alpha');
    var sm2 = new SemanticVersion(0, 0, 0, 'beta');
    expect(sm < sm2, equals(true));
  });

  test('different build components do not affect test', () {
    var sm = new SemanticVersion(0, 0, 0, null, '200');
    var sm2 = new SemanticVersion(0, 0, 0, null, '201');
    expect(sm == sm2, equals(true));
  });

  test('can compare alphabetic pre-release names', () {
    var sm = new SemanticVersion(0, 0, 0, 'alpha');
    var sm2 = new SemanticVersion(0, 0, 0, 'beta');
    expect(sm < sm2, equals(true));
  });

    test('can compare numeric pre-release names', () {
      var sm = new SemanticVersion(0, 0, 0, '200');
      var sm2 = new SemanticVersion(0, 0, 0, '201');
      expect(sm < sm2, equals(true));
  });

    test('longer pre-release name wins', () {
      var sm = new SemanticVersion(0, 0, 0, 'alpha');
      var sm2 = new SemanticVersion(0, 0, 0, 'alpha.1');
      expect(sm < sm2, equals(true));
  });
}
