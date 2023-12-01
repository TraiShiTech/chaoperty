class InvoiceModel {
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
  String? meter;
  String? ptser;
  String? ptname;
  String? bno;
  String? bank;
  String? img;
  String? btype;
  String? c_ln;
  String? c_zn;
  String? cid;
  String? user;

  InvoiceModel({
    this.ser,
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
    this.meter,
    this.ptser,
    this.ptname,
    this.bno,
    this.bank,
    this.img,
    this.btype,
    this.c_ln,
    this.c_zn,
    this.cid,
    this.user,
  });

  InvoiceModel.fromJson(Map<String, dynamic> json) {
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
    meter = json['meter'];
    ptser = json['ptser'];
    ptname = json['ptname'];
    bno = json['bno'];
    bank = json['bank'];
    img = json['img'];
    btype = json['btype'];
    c_ln = json['c_ln'];
    c_zn = json['c_zn'];
    cid = json['cid'];
    user = json['user'];
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
    data['meter'] = this.meter;
    data['ptser'] = this.ptser;
    data['ptname'] = this.ptname;
    data['bno'] = this.bno;
    data['bank'] = this.bank;
    data['img'] = this.img;
    data['btype'] = this.btype;
    data['c_ln'] = this.c_ln;
    data['c_zn'] = this.c_zn;
    data['cid'] = this.cid;
    data['user'] = this.user;

    return data;
  }
}
