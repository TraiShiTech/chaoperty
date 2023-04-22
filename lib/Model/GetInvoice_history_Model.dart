class InvoiceHistoryModel {
  String? ser;
  String? daterec;
  String? date;
  String? dateacc;
  String? dtype;
  String? mrp;
  String? docno;
  String? showdate;
  String? billno;
  String? custno;
  String? supno;
  String? refno;
  String? descr;
  String? billdate;
  String? ovalue;
  String? nvalue;
  String? qty;
  String? pri;
  String? pvat;
  String? vat;
  String? nvat;
  String? wht;
  String? nwht;
  String? camt;
  String? wtax;
  String? wamt;
  String? dis;
  String? disendbillper;
  String? disendbill;
  String? deposit;
  String? cn;
  String? amt;
  String? remark;
  String? note;
  String? vat_t;
  String? pvat_t;
  String? total_t;
  String? wht_t;
  String? cid;

  InvoiceHistoryModel(
      {this.ser,
      this.daterec,
      this.date,
      this.dateacc,
      this.dtype,
      this.mrp,
      this.docno,
      this.showdate,
      this.billno,
      this.custno,
      this.supno,
      this.refno,
      this.descr,
      this.billdate,
      this.ovalue,
      this.nvalue,
      this.qty,
      this.pri,
      this.pvat,
      this.vat,
      this.nvat,
      this.wht,
      this.nwht,
      this.camt,
      this.wtax,
      this.wamt,
      this.dis,
      this.disendbillper,
      this.disendbill,
      this.deposit,
      this.cn,
      this.amt,
      this.remark,
      this.note,
      this.vat_t,
      this.pvat_t,
      this.total_t,
      this.wht_t,
      this.cid});

  InvoiceHistoryModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    daterec = json['daterec'];
    date = json['date'];
    dateacc = json['dateacc'];
    dtype = json['dtype'];
    mrp = json['mrp'];
    docno = json['docno'];
    showdate = json['showdate'];
    billno = json['billno'];
    custno = json['custno'];
    supno = json['supno'];
    refno = json['refno'];
    descr = json['descr'];
    billdate = json['billdate'];
    ovalue = json['ovalue'];
    nvalue = json['nvalue'];
    qty = json['qty'];
    pri = json['pri'];
    pvat = json['pvat'];
    vat = json['vat'];
    nvat = json['nvat'];
    wht = json['wht'];
    nwht = json['nwht'];
    camt = json['camt'];
    wtax = json['wtax'];
    wamt = json['wamt'];
    dis = json['dis'];
    disendbillper = json['disendbillper'];
    disendbill = json['disendbill'];
    deposit = json['deposit'];
    cn = json['cn'];
    amt = json['amt'];
    remark = json['remark'];
    note = json['note'];
    vat_t = json['vat_t'];
    pvat_t = json['pvat_t'];
    total_t = json['total_t'];
    wht_t = json['wht_t'];
    cid = json['cid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['daterec'] = this.daterec;
    data['date'] = this.date;
    data['dateacc'] = this.dateacc;
    data['dtype'] = this.dtype;
    data['mrp'] = this.mrp;
    data['docno'] = this.docno;
    data['showdate'] = this.showdate;
    data['billno'] = this.billno;
    data['custno'] = this.custno;
    data['supno'] = this.supno;
    data['refno'] = this.refno;
    data['descr'] = this.descr;
    data['billdate'] = this.billdate;
    data['ovalue'] = this.ovalue;
    data['nvalue'] = this.nvalue;
    data['qty'] = this.qty;
    data['pri'] = this.pri;
    data['pvat'] = this.pvat;
    data['vat'] = this.vat;
    data['nvat'] = this.nvat;
    data['wht'] = this.wht;
    data['nwht'] = this.nwht;
    data['camt'] = this.camt;
    data['wtax'] = this.wtax;
    data['wamt'] = this.wamt;
    data['dis'] = this.dis;
    data['disendbillper'] = this.disendbillper;
    data['disendbill'] = this.disendbill;
    data['deposit'] = this.deposit;
    data['cn'] = this.cn;
    data['amt'] = this.amt;
    data['remark'] = this.remark;
    data['note'] = this.note;
    data['vat_t'] = this.vat_t;
    data['pvat_t'] = this.pvat_t;
    data['total_t'] = this.total_t;
    data['wht_t'] = this.wht_t;
    data['cid'] = this.cid;


    return data;
  }
}
