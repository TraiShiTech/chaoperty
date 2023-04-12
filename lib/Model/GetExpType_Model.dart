class ExpTypeModel {
  String? ser;
  String? type;
  String? etype;
  String? etypex;
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
  String? data_update;

  ExpTypeModel(
      {this.ser,
      this.type,
      this.etype,
      this.etypex,
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
      this.rser,
      this.data_update});

  ExpTypeModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    type = json['type'];
    etype = json['etype'];
    etypex = json['etypex'];
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
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['type'] = this.type;
    data['etype'] = this.etype;
    data['etypex'] = this.etypex;
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
    data['data_update'] = this.data_update;
    return data;
  }
}
