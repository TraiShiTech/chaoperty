class InvoiceReModel {
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
  String? scname;
  String? cname;
  String? ln;
  String? zser;
  String? expser;
  String? expname;
  String? amt_expname;
  String? total_dis;
  String? total_bill;
  String? exp_array;
  String? cid;
  String? zn;
  String? total_vat;
  String? total_wht;

  InvoiceReModel({
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
    this.scname,
    this.cname,
    this.ln,
    this.zser,
    this.expser,
    this.expname,
    this.amt_expname,
    this.total_dis,
    this.total_bill,
    this.exp_array,
    this.cid,
    this.zn,
    this.total_vat,
    this.total_wht,
  });

  InvoiceReModel.fromJson(Map<String, dynamic> json) {
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
    scname = json['scname'];
    cname = json['cname'];
    ln = json['ln'];
    zser = json['zser'];
    expser = json['expser'];
    expname = json['expname'];
    amt_expname = json['amt_expname'];
    total_dis = json['total_dis'];
    total_bill = json['total_bill'];
    exp_array = json['exp_array'];
    cid = json['cid'];
    zn = json['zn'];
    total_vat = json['total_vat'];
    total_wht = json['total_wht'];
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
    data['scname'] = this.scname;
    data['cname'] = this.cname;
    data['ln'] = this.ln;
    data['zser'] = this.zser;

    data['expser'] = this.expser;
    data['expname'] = this.expname;
    data['amt_expname'] = this.amt_expname;
    data['total_dis'] = this.total_dis;
    data['total_bill'] = this.total_bill;
    data['exp_array'] = this.exp_array;
    data['cid'] = this.cid;
    data['zn'] = this.zn;
    data['total_vat'] = this.total_vat;
    data['total_wht'] = this.total_wht;
    return data;
  }
}
