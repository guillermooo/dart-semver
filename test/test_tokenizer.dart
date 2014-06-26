import 'package:unittest/unittest.dart';
import 'package:semver/source/tokenizer.dart';

void main() {
  test('can tokenize simple tag', () {
    var tag = '0.1.0';
    var sm = new SemanticVersionTokenizer(tag);
    var expected = new Map();
    expected['major'] = 0;
    expected['minor'] = 1;
    expected['patch'] = 0;
    expect(sm.tokenize(), equals(expected));
  });

  test('can tokenize tag with alphabetic pre-release part', () {
    var tag = '0.1.0-alpha';
    var sm = new SemanticVersionTokenizer(tag);
    var expected = new Map();
    expected['major'] = 0;
    expected['minor'] = 1;
    expected['patch'] = 0;
    expected['pre'] = 'alpha';
    expect(sm.tokenize(), equals(expected));
  });

  test('can tokenize tag with numeric pre-release part', () {
    var tag = '0.1.0-100';
    var sm = new SemanticVersionTokenizer(tag);
    var expected = new Map();
    expected['major'] = 0;
    expected['minor'] = 1;
    expected['patch'] = 0;
    expected['pre'] = '100';
    expect(sm.tokenize(), equals(expected));
  });

  test('can tokenize tag with alphanumeric pre-release part', () {
    var tag = '0.1.0-alpha100';
    var sm = new SemanticVersionTokenizer(tag);
    var expected = new Map();
    expected['major'] = 0;
    expected['minor'] = 1;
    expected['patch'] = 0;
    expected['pre'] = 'alpha100';
    expect(sm.tokenize(), equals(expected));
  });

  test('can tokenize tag with complex pre-release part', () {
    var tag = '0.1.0-alpha.100';
    var sm = new SemanticVersionTokenizer(tag);
    var expected = new Map();
    expected['major'] = 0;
    expected['minor'] = 1;
    expected['patch'] = 0;
    expected['pre'] = 'alpha.100';
    expect(sm.tokenize(), equals(expected));
  });

  // with build part
  test('can tokenize tag with alphabetic build part', () {
    var tag = '0.1.0+alpha';
    var sm = new SemanticVersionTokenizer(tag);
    var expected = new Map();
    expected['major'] = 0;
    expected['minor'] = 1;
    expected['patch'] = 0;
    expected['build'] = 'alpha';
    expect(sm.tokenize(), equals(expected));
  });

  test('can tokenize tag with numeric build part', () {
    var tag = '0.1.0+100';
    var sm = new SemanticVersionTokenizer(tag);
    var expected = new Map();
    expected['major'] = 0;
    expected['minor'] = 1;
    expected['patch'] = 0;
    expected['build'] = '100';
    expect(sm.tokenize(), equals(expected));
  });

  test('can tokenize tag with alphanumeric build part', () {
    var tag = '0.1.0+alpha100';
    var sm = new SemanticVersionTokenizer(tag);
    var expected = new Map();
    expected['major'] = 0;
    expected['minor'] = 1;
    expected['patch'] = 0;
    expected['build'] = 'alpha100';
    expect(sm.tokenize(), equals(expected));
  });

  test('can tokenize tag with complex build part', () {
    var tag = '0.1.0+alpha.100';
    var sm = new SemanticVersionTokenizer(tag);
    var expected = new Map();
    expected['major'] = 0;
    expected['minor'] = 1;
    expected['patch'] = 0;
    expected['build'] = 'alpha.100';
    expect(sm.tokenize(), equals(expected));
  });
}


