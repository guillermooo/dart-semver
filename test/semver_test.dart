import 'package:test/test.dart';
import 'package:semver/semver.dart';

void main() {
  test('can instantiate from string', () {
    var sm = new SemanticVersion.fromString('0.1.0');
    expect(sm.toString(), '0.1.0');
  });

  test('can instantiate from map', () {
    var data = new Map();
    data['major'] = 0;
    data['minor'] = 1;
    data['patch'] = 0;
    var sm = new SemanticVersion.fromMap(data);
    expect(sm.toString(), '0.1.0');
  });

  test('can instantiate from default constructor', () {
    var sm = new SemanticVersion(0, 1, 0);
    expect(sm.toString(), '0.1.0');
  });

  // comparison ops
  test('can detect identical versions', () {
    var sm = new SemanticVersion(0, 1, 0);
    var sm2 = new SemanticVersion(0, 1, 0);
    expect(sm == sm2, isTrue);
    expect(sm.compareTo(sm2), 0);
  });

  test('can detect identical complex versions (pre-release)', () {
    var sm = new SemanticVersion(0, 1, 0, 'alpha.10');
    var sm2 = new SemanticVersion(0, 1, 0, 'alpha.10');
    expect(sm == sm2, isTrue);
    expect(sm.compareTo(sm2), 0);
  });

  test('can detect lesser version based on major component', () {
    var sm = new SemanticVersion(0, 0, 0);
    var sm2 = new SemanticVersion(1, 0, 0);
    expect(sm < sm2, isTrue);
    expect(sm.compareTo(sm2), -1);
  });

  test('can detect lesser version based on minor component', () {
    var sm = new SemanticVersion(0, 0, 0);
    var sm2 = new SemanticVersion(0, 1, 0);
    expect(sm < sm2, isTrue);
    expect(sm.compareTo(sm2), -1);
  });

  test('can detect lesser version based on patch component', () {
    var sm = new SemanticVersion(0, 0, 0);
    var sm2 = new SemanticVersion(0, 0, 1);
    expect(sm < sm2, isTrue);
    expect(sm.compareTo(sm2), -1);
  });

  test('pre-release part makes version smaller', () {
    var sm = new SemanticVersion(0, 0, 0);
    var sm2 = new SemanticVersion(0, 0, 0, 'alpha');
    expect(sm < sm2, isFalse);
    expect(sm.compareTo(sm2), 1);
  });

  test('absence/presence of build component does not affect test', () {
    var sm = new SemanticVersion(0, 0, 0);
    var sm2 = new SemanticVersion(0, 0, 0, null, '20201010');
    expect(sm == sm2, isTrue);
    expect(sm.compareTo(sm2), 0);
  });

  test('checking for lesser version fails based on major component', () {
    var sm = new SemanticVersion(1, 0, 0);
    var sm2 = new SemanticVersion(0, 0, 0);
    expect(sm < sm2, isFalse);
    expect(sm.compareTo(sm2), 1);
  });

  test('checking for lesser version fails based on minor component', () {
    var sm = new SemanticVersion(0, 1, 0);
    var sm2 = new SemanticVersion(0, 0, 0);
    expect(sm < sm2, isFalse);
    expect(sm.compareTo(sm2), 1);
  });

  test('checking for lesser version fails based on patch component', () {
    var sm = new SemanticVersion(0, 1, 0);
    var sm2 = new SemanticVersion(0, 0, 0);
    expect(sm < sm2, isFalse);
    expect(sm.compareTo(sm2), 1);
  });

  test('can detect lesser version based on pre-release component', () {
    var sm = new SemanticVersion(0, 0, 0, 'alpha');
    var sm2 = new SemanticVersion(0, 0, 0, 'beta');
    expect(sm < sm2, isTrue);
    expect(sm.compareTo(sm2), -1);
  });

  test('different build components do not affect test', () {
    var sm = new SemanticVersion(0, 0, 0, null, '200');
    var sm2 = new SemanticVersion(0, 0, 0, null, '201');
    expect(sm == sm2, isTrue);
    expect(sm.compareTo(sm2), 0);
  });

  test('can compare alphabetic pre-release names', () {
    var sm = new SemanticVersion(0, 0, 0, 'alpha');
    var sm2 = new SemanticVersion(0, 0, 0, 'beta');
    expect(sm < sm2, isTrue);
    expect(sm.compareTo(sm2), -1);
  });

  test('can compare numeric pre-release names', () {
    var sm = new SemanticVersion(0, 0, 0, '200');
    var sm2 = new SemanticVersion(0, 0, 0, '201');
    expect(sm < sm2, isTrue);
    expect(sm.compareTo(sm2), -1);
  });

  test('longer pre-release name wins', () {
    var sm = new SemanticVersion(0, 0, 0, 'alpha');
    var sm2 = new SemanticVersion(0, 0, 0, 'alpha.1');
    expect(sm < sm2, isTrue);
    expect(sm.compareTo(sm2), -1);
  });

  test('should be sortable', () {
    var versionList = [
      new SemanticVersion(0, 1, 0), // 3
      new SemanticVersion(0, 0, 0), // 0
      new SemanticVersion(0, 0, 1), // 1
      new SemanticVersion(0, 1, 0, 'dev') // 2
    ];

    versionList.sort();
    
    expect(versionList[0], new SemanticVersion(0, 0, 0));
    expect(versionList[1], new SemanticVersion(0, 0, 1));
    expect(versionList[2], new SemanticVersion(0, 1, 0, 'dev'));
    expect(versionList[3], new SemanticVersion(0, 1, 0));
  });
}
