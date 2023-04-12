class TestDupModel {
  String? ser;
  String? type;
  String? dtype;
  String? dtypex;
  String? billsale;
  String? bills;
  String? kind;
  String? bno;
  String? bnox;
  String? tqt;
  String? qt;
  String? am;
  String? qs;
  String? qb;
  String? descr;
  String? chead;
  String? creport;
  String? creportx;
  String? user;
  String? rser;

  TestDupModel(
      {this.ser,
      this.type,
      this.dtype,
      this.dtypex,
      this.billsale,
      this.bills,
      this.kind,
      this.bno,
      this.bnox,
      this.tqt,
      this.qt,
      this.am,
      this.qs,
      this.qb,
      this.descr,
      this.chead,
      this.creport,
      this.creportx,
      this.user,
      this.rser});

  TestDupModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    type = json['type'];
    dtype = json['dtype'];
    dtypex = json['dtypex'];
    billsale = json['billsale'];
    bills = json['bills'];
    kind = json['kind'];
    bno = json['bno'];
    bnox = json['bnox'];
    tqt = json['tqt'];
    qt = json['qt'];
    am = json['am'];
    qs = json['qs'];
    qb = json['qb'];
    descr = json['descr'];
    chead = json['chead'];
    creport = json['creport'];
    creportx = json['creportx'];
    user = json['user'];
    rser = json['rser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['type'] = this.type;
    data['dtype'] = this.dtype;
    data['dtypex'] = this.dtypex;
    data['billsale'] = this.billsale;
    data['bills'] = this.bills;
    data['kind'] = this.kind;
    data['bno'] = this.bno;
    data['bnox'] = this.bnox;
    data['tqt'] = this.tqt;
    data['qt'] = this.qt;
    data['am'] = this.am;
    data['qs'] = this.qs;
    data['qb'] = this.qb;
    data['descr'] = this.descr;
    data['chead'] = this.chead;
    data['creport'] = this.creport;
    data['creportx'] = this.creportx;
    data['user'] = this.user;
    data['rser'] = this.rser;
    return data;
  }
}
