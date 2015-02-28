// Copyright (c) 2015, Guillermo López-Anglada. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library semver.tokenizer;

import 'package:string_scanner/string_scanner.dart';

Map<String, String> tokenize(String source) {
  var result = {};
  var scanner = new StringScanner(source);

  scanner.expect(new RegExp(r'(\d+)\.(\d+)\.(\d+)'));
  result['major'] = int.parse(scanner.lastMatch[1]);
  result['minor'] = int.parse(scanner.lastMatch[2]);
  result['patch'] = int.parse(scanner.lastMatch[3]);

  if (!scanner.scan(new RegExp(r'[\+-]'))) {
    scanner.expectDone();
    return result;
  }

  if (scanner.lastMatch[0] == '-') {
    scanner.expect(new RegExp(r'[^\+ ]+'));
    result['pre'] = scanner.lastMatch[0];
  }

  if (scanner.lastMatch[0] != '+' && scanner.isDone) return result;

  scanner.expect(new RegExp(r'[^ ]+'));
  result['build'] = scanner.lastMatch[0];
  scanner.expectDone();
  return result;
}
