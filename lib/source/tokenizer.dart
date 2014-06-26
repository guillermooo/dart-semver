
class SemanticVersionTokenizer {
  final String _source;
  int _index = -1;
  Map _version = new Map();

  SemanticVersionTokenizer(this._source);

  String get current => this._source[this._index];

  String consume() {
    this._index++;
    if (this._index > (this._source.length - 1)) {
      this._index--;
      throw new Exception("EOF");
    }
    return this.current;
  }

  int tokenizeInt() {
    StringBuffer unparsedInt = new StringBuffer();
    unparsedInt.write(this.current);

    try {
      while ('01234567890'.contains(this.consume())) {
        unparsedInt.write(this.current);
      }
    }
    catch (Exception) {/* ignore */}
    finally { return int.parse(unparsedInt.toString()); }
  }

  void setMandatoryPart(int value) {
    if (this._version.isEmpty) {
      this._version['major'] = value;
    } else if (!this._version.containsKey('minor')) {
      this._version['minor'] = value;
    } else {
      this._version['patch'] = value;
    }
  }

  void tokenizeMandatoryParts() {
    !'0123456789'.contains(this.current) ?
        throw new Exception('wrong format: ${this._source}') : true;
   this.setMandatoryPart(this.tokenizeInt());
   this.current != '.' ? throw new Exception('wrong format: ${this._source}')
                       : true;
   this.consume();
   this.setMandatoryPart(this.tokenizeInt());
   this.current != '.' ? throw new Exception('wrong format: ${this._source}')
                       : true;
   this.consume();
   this.setMandatoryPart(this.tokenizeInt());
  }

 void tokenizePreRelease() {
   StringBuffer everything = new StringBuffer();
   everything.write(this._source[this._index]);

   try {
     while (this.consume() != '+') {
       everything.write(this.current);
     }
   }
   catch (Exception) {/* ignore */}
   finally { this._version['pre'] = everything.toString(); }
 }

 void tokenizeBuild() {
   StringBuffer everything = new StringBuffer();
   everything.write(this._source[this._index]);

   try {
     while (this.consume() != '') {
       everything.write(this.current);
     }
   }
   catch (Exception) {/* ignore */}
   finally { this._version['build'] = everything.toString(); }
 }

  Map tokenize() {
    this.consume();
    this.tokenizeMandatoryParts();

    if (this._index < (this._source.length - 1)) {
      switch (this.current) {
        case '-':
          this.consume();
          this.tokenizePreRelease();
          break;
        case '+':
          this.consume();
          this.tokenizeBuild();
          return this._version;
        default:
          throw new Exception('bad tag');
      }
    }

    if (this._index < (this._source.length - 1)) {
      if (this.current == '+') {
          this.consume();
          this.tokenizeBuild();
      } else {
          throw new Exception('bad tag');
      }
    }

    return this._version;
  }
}

