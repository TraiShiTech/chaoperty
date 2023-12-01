class CFinnancetransModel {
  String? ser;
  String? datex;
  String? timex;
  String? date;
  String? dateacc;
  String? dtype;
  String? user;
  String? rser;
  String? docno;
  String? refno;
  String? tser;
  String? tno;
  String? type;
  String? bank;
  String? bno;
  String? chqno;
  String? chqdate;
  String? chqbank;
  String? chqsaka;
  String? amt;
  String? total;
  String? remark;
  String? st;
  String? dataUpdate;
  String? doctax;

  CFinnancetransModel(
      {this.ser,
      this.datex,
      this.timex,
      this.date,
      this.dateacc,
      this.dtype,
      this.user,
      this.rser,
      this.docno,
      this.refno,
      this.tser,
      this.tno,
      this.type,
      this.bank,
      this.bno,
      this.chqno,
      this.chqdate,
      this.chqbank,
      this.chqsaka,
      this.amt,
      this.total,
      this.remark,
      this.st,
      this.dataUpdate,
      this.doctax});

  CFinnancetransModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    date = json['date'];
    dateacc = json['dateacc'];
    dtype = json['dtype'];
    user = json['user'];
    rser = json['rser'];
    docno = json['docno'];
    refno = json['refno'];
    tser = json['tser'];
    tno = json['tno'];
    type = json['type'];
    bank = json['bank'];
    bno = json['bno'];
    chqno = json['chqno'];
    chqdate = json['chqdate'];
    chqbank = json['chqbank'];
    chqsaka = json['chqsaka'];
    amt = json['amt'];
    total = json['total'];
    remark = json['remark'];
    st = json['st'];
    dataUpdate = json['data_update'];
    doctax = json['doctax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['date'] = this.date;
    data['dateacc'] = this.dateacc;
    data['dtype'] = this.dtype;
    data['user'] = this.user;
    data['rser'] = this.rser;
    data['docno'] = this.docno;
    data['refno'] = this.refno;
    data['tser'] = this.tser;
    data['tno'] = this.tno;
    data['type'] = this.type;
    data['bank'] = this.bank;
    data['bno'] = this.bno;
    data['chqno'] = this.chqno;
    data['chqdate'] = this.chqdate;
    data['chqbank'] = this.chqbank;
    data['chqsaka'] = this.chqsaka;
    data['amt'] = this.amt;
    data['total'] = this.total;
    data['remark'] = this.remark;
    data['st'] = this.st;
    data['data_update'] = this.dataUpdate;
    data['doctax'] = this.doctax;
    return data;
  }
}
