class DoctypeDefaultModel {
  String? ser;
  String? type;
  String? dtype;

  String? billsale;
  String? bills;
  String? kind;
  String? bno;

  String? tqt;
  String? qt;
  String? am;
  String? qs;
  String? qb;
  String? descr;
  String? chead;
  String? creport;
  String? creportx;

  DoctypeDefaultModel(
      {this.ser,
      this.type,
      this.dtype,
      this.billsale,
      this.bills,
      this.kind,
      this.bno,
      this.tqt,
      this.qt,
      this.am,
      this.qs,
      this.qb,
      this.descr,
      this.chead,
      this.creport,
      this.creportx});

  DoctypeDefaultModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    type = json['type'];
    dtype = json['dtype'];

    billsale = json['billsale'];
    bills = json['bills'];
    kind = json['kind'];
    bno = json['bno'];

    tqt = json['tqt'];
    qt = json['qt'];
    am = json['am'];
    qs = json['qs'];
    qb = json['qb'];
    descr = json['descr'];
    chead = json['chead'];
    creport = json['creport'];
    creportx = json['creportx'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['type'] = this.type;
    data['dtype'] = this.dtype;

    data['billsale'] = this.billsale;
    data['bills'] = this.bills;
    data['kind'] = this.kind;
    data['bno'] = this.bno;

    data['tqt'] = this.tqt;
    data['qt'] = this.qt;
    data['am'] = this.am;
    data['qs'] = this.qs;
    data['qb'] = this.qb;
    data['descr'] = this.descr;
    data['chead'] = this.chead;
    data['creport'] = this.creport;
    data['creportx'] = this.creportx;

    return data;
  }
}
