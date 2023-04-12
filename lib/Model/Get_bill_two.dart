class DoctypeTwoModel {
  String? ser;
  String? ss;
  String? type;
  String? dtype;
  String? doccode;
  String? yytype;
  String? yy;
  String? mm;
  String? ndegit;
  String? tsac;
  String? billsale;
  String? bills;
  String? kind;
  String? bno;
  String? startbill;
  String? tqt;
  String? qt;
  String? am;
  String? qs;
  String? qb;
  String? descr;
  String? chead;
  String? creport;
  String? creportx;
  String? npage;
  String? dataUpdate;

  DoctypeTwoModel(
      {this.ser,
      this.ss,
      this.type,
      this.dtype,
      this.doccode,
      this.yytype,
      this.yy,
      this.mm,
      this.ndegit,
      this.tsac,
      this.billsale,
      this.bills,
      this.kind,
      this.bno,
      this.startbill,
      this.tqt,
      this.qt,
      this.am,
      this.qs,
      this.qb,
      this.descr,
      this.chead,
      this.creport,
      this.creportx,
      this.npage,
      this.dataUpdate});

  DoctypeTwoModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    ss = json['ss'];
    type = json['type'];
    dtype = json['dtype'];
    doccode = json['doccode'];
    yytype = json['yytype'];
    yy = json['yy'];
    mm = json['mm'];
    ndegit = json['ndegit'];
    tsac = json['tsac'];
    billsale = json['billsale'];
    bills = json['bills'];
    kind = json['kind'];
    bno = json['bno'];
    startbill = json['startbill'];
    tqt = json['tqt'];
    qt = json['qt'];
    am = json['am'];
    qs = json['qs'];
    qb = json['qb'];
    descr = json['descr'];
    chead = json['chead'];
    creport = json['creport'];
    creportx = json['creportx'];
    npage = json['npage'];
    dataUpdate = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['ss'] = this.ss;
    data['type'] = this.type;
    data['dtype'] = this.dtype;
    data['doccode'] = this.doccode;
    data['yytype'] = this.yytype;
    data['yy'] = this.yy;
    data['mm'] = this.mm;
    data['ndegit'] = this.ndegit;
    data['tsac'] = this.tsac;
    data['billsale'] = this.billsale;
    data['bills'] = this.bills;
    data['kind'] = this.kind;
    data['bno'] = this.bno;
    data['startbill'] = this.startbill;
    data['tqt'] = this.tqt;
    data['qt'] = this.qt;
    data['am'] = this.am;
    data['qs'] = this.qs;
    data['qb'] = this.qb;
    data['descr'] = this.descr;
    data['chead'] = this.chead;
    data['creport'] = this.creport;
    data['creportx'] = this.creportx;
    data['npage'] = this.npage;
    data['data_update'] = this.dataUpdate;
    return data;
  }
}
