class FinnancetransModel {
  String? ser;
  String? datex;
  String? timex;
  String? user;
  String? rser;
  String? daterec;
  String? timerec;
  String? date;
  String? dateacc;
  String? dtype;
  String? shopno;
  String? pos;
  String? docno;
  String? custno;
  String? supno;
  String? refno;
  String? receiptSer;
  String? accode;
  String? accodechq;
  String? type;
  String? bank;
  String? bno;
  String? chqno;
  String? chqdate;
  String? chqbank;
  String? chqsaka;
  String? exchange;
  String? amt;
  String? exrate;
  String? refund;
  String? total;
  String? remark;
  String? acFrom;
  String? acTo;
  String? checkSt;
  String? descr;
  String? slip;
  String? pdate;
  String? ptime;
  String? disper;
  String? dataUpdate;

  FinnancetransModel(
      {this.ser,
      this.datex,
      this.timex,
      this.user,
      this.rser,
      this.daterec,
      this.timerec,
      this.date,
      this.dateacc,
      this.dtype,
      this.shopno,
      this.pos,
      this.docno,
      this.custno,
      this.supno,
      this.refno,
      this.receiptSer,
      this.accode,
      this.accodechq,
      this.type,
      this.bank,
      this.bno,
      this.chqno,
      this.chqdate,
      this.chqbank,
      this.chqsaka,
      this.exchange,
      this.amt,
      this.exrate,
      this.refund,
      this.total,
      this.remark,
      this.acFrom,
      this.acTo,
      this.checkSt,
      this.descr,
      this.slip,
      this.pdate,
      this.ptime,
      this.disper,
      this.dataUpdate});

  FinnancetransModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    user = json['user'];
    rser = json['rser'];
    daterec = json['daterec'];
    timerec = json['timerec'];
    date = json['date'];
    dateacc = json['dateacc'];
    dtype = json['dtype'];
    shopno = json['shopno'];
    pos = json['pos'];
    docno = json['docno'];
    custno = json['custno'];
    supno = json['supno'];
    refno = json['refno'];
    receiptSer = json['receipt_ser'];
    accode = json['accode'];
    accodechq = json['accodechq'];
    type = json['type'];
    bank = json['bank'];
    bno = json['bno'];
    chqno = json['chqno'];
    chqdate = json['chqdate'];
    chqbank = json['chqbank'];
    chqsaka = json['chqsaka'];
    exchange = json['exchange'];
    amt = json['amt'];
    exrate = json['exrate'];
    refund = json['refund'];
    total = json['total'];
    remark = json['remark'];
    acFrom = json['ac_from'];
    acTo = json['ac_to'];
    checkSt = json['check_st'];
    descr = json['descr'];
    slip = json['slip'];
    pdate = json['pdate'];
    ptime = json['ptime'];
    disper = json['disper'];
    dataUpdate = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['user'] = this.user;
    data['rser'] = this.rser;
    data['daterec'] = this.daterec;
    data['timerec'] = this.timerec;
    data['date'] = this.date;
    data['dateacc'] = this.dateacc;
    data['dtype'] = this.dtype;
    data['shopno'] = this.shopno;
    data['pos'] = this.pos;
    data['docno'] = this.docno;
    data['custno'] = this.custno;
    data['supno'] = this.supno;
    data['refno'] = this.refno;
    data['receipt_ser'] = this.receiptSer;
    data['accode'] = this.accode;
    data['accodechq'] = this.accodechq;
    data['type'] = this.type;
    data['bank'] = this.bank;
    data['bno'] = this.bno;
    data['chqno'] = this.chqno;
    data['chqdate'] = this.chqdate;
    data['chqbank'] = this.chqbank;
    data['chqsaka'] = this.chqsaka;
    data['exchange'] = this.exchange;
    data['amt'] = this.amt;
    data['exrate'] = this.exrate;
    data['refund'] = this.refund;
    data['total'] = this.total;
    data['remark'] = this.remark;
    data['ac_from'] = this.acFrom;
    data['ac_to'] = this.acTo;
    data['check_st'] = this.checkSt;
    data['descr'] = this.descr;
    data['slip'] = this.slip;
    data['pdate'] = this.pdate;
    data['ptime'] = this.ptime;
    data['disper'] = this.disper;
    data['data_update'] = this.dataUpdate;
    return data;
  }
}
