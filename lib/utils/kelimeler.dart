class Kelimeler {
  int _kelimeID;
  String _kelime;
  String _anlam;
  String cumle;
  int _learned;
  String cumleanlam;

  Kelimeler(this._kelime, this._anlam, this._learned,
      {this.cumle, this.cumleanlam});
  Kelimeler.withID(this._kelimeID, this._kelime, this._anlam, this._learned,
      {this.cumle, this.cumleanlam});
  Kelimeler.fromMap(Map<String, dynamic> map) {
    this._kelimeID = map['id'];
    this._kelime = map['kelime'];
    this._anlam = map['anlam'];
    this.cumle = map['cumle'];
    this._learned = map['learned'];
    this.cumleanlam = map['cumleanlam'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map['id'] = this._kelimeID;
    map['kelime'] = this._kelime;
    map['anlam'] = this._anlam;
    map['cumle'] = this.cumle;
    map['learned'] = this._learned;
    map['cumleanlam'] = this.cumleanlam;
    return map;
  }

  int get getKelimeID => this._kelimeID;
  String get getKelime => this._kelime;
  String get getAnlam => this._anlam;
  String get getCumle => this.cumle;
  int get getlearned => this._learned;
  String get getCumleAnlam => this.cumleanlam;

  @override
  String toString() {
    return '(${this._kelimeID}, ${this._kelime}, ${this._anlam}, ${this._learned}, ${this.cumle}, ${this.cumleanlam})';
  }
}
