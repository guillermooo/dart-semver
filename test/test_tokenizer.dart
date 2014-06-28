import 'package:unittest/unittest.dart';
import 'package:semver/source/tokenizer.dart';

void main() {
  group('mandatory parts:', () {
    test('can tokenize', () {
      var tag = '0.1.0';
      var sm = new SemanticVersionTokenizer(tag);
      var expected = { 'major': 0, 'minor': 1, 'patch': 0 };
      expect(sm.tokenize(), equals(expected));
    });
  });

  group('pre-release part:', () {
    test('can tokenize alphabetic', () {
      var tag = '0.1.0-alpha';
      var sm = new SemanticVersionTokenizer(tag);
      var expected = {'major': 0, 'minor': 1, 'patch': 0, 'pre': 'alpha'};
      expect(sm.tokenize(), equals(expected));
    });

    test('can tokenize numeric', () {
      var tag = '0.1.0-100';
      var sm = new SemanticVersionTokenizer(tag);
      var expected = {'major': 0, 'minor': 1, 'patch': 0, 'pre': '100'};
      expect(sm.tokenize(), equals(expected));
    });

    test('can tokenize alphanumeric', () {
      var tag = '0.1.0-alpha100';
      var sm = new SemanticVersionTokenizer(tag);
      var expected = {'major': 0, 'minor': 1, 'patch': 0, 'pre': 'alpha100'};
      expect(sm.tokenize(), equals(expected));
    });

    test('can tokenize complex', () {
      var tag = '0.1.0-alpha.100';
      var sm = new SemanticVersionTokenizer(tag);
      var expected = {'major': 0, 'minor': 1, 'patch': 0, 'pre': 'alpha.100'};
      expect(sm.tokenize(), equals(expected));
    });
  });

  group('build part:', () {
    test('can tokenize alphabetic', () {
      var tag = '0.1.0+alpha';
      var sm = new SemanticVersionTokenizer(tag);
      var expected = {'major': 0, 'minor': 1, 'patch': 0, 'build': 'alpha'};
      expect(sm.tokenize(), equals(expected));
    });

    test('can tokenize numeric', () {
      var tag = '0.1.0+100';
      var sm = new SemanticVersionTokenizer(tag);
      var expected = {'major': 0, 'minor': 1, 'patch': 0, 'build': '100'};
      expect(sm.tokenize(), equals(expected));
    });

    test('can tokenize alphanumeric', () {
      var tag = '0.1.0+alpha100';
      var sm = new SemanticVersionTokenizer(tag);
      var expected = {'major': 0, 'minor': 1, 'patch': 0, 'build': 'alpha100'};
      expect(sm.tokenize(), equals(expected));
    });

    test('can tokenize complex', () {
      var tag = '0.1.0+alpha.100';
      var sm = new SemanticVersionTokenizer(tag);
      var expected = {'major': 0, 'minor': 1, 'patch': 0, 'build': 'alpha.100'};
      expect(sm.tokenize(), equals(expected));
    });
  });
}
