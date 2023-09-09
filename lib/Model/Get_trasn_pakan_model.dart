class TransPakanModel {
  String? ser;
  String? datex;
  String? timex;
  String? user;
  String? rser;
  String? daterec;
  String? timerec;
  String? date;
  String? dateacc;
  String? duedate;
  String? dateCheckin;
  String? dateCheckout;
  String? shopno;
  String? pos;
  String? shifts;
  String? st;
  String? dochtax;
  String? doctax;
  String? cid;
  String? meter;
  String? docno;
  String? custno;
  String? supno;
  String? supnox;
  String? refno;
  String? refnox;
  String? po;
  String? inv;
  String? accode;
  String? accodeAccrued;
  String? service;
  String? expense;
  String? xxxno;
  String? xxxdate;
  String? barcode;
  String? stcode;
  String? name;
  String? namex;
  String? unit;
  String? no;
  String? tqty;
  String? qty1;
  String? qty2;
  String? qty3;
  String? qty4;
  String? qty5;
  String? agqty;
  String? emp;
  String? distype;
  String? dis;
  String? discount;
  String? deposit;
  String? other;
  String? fine;
  String? expser;
  String? expname;
  String? term;
  String? sdate;
  String? ldate;
  String? amt;
  String? amtx;
  String? vtype;
  String? nvat;
  String? tax;
  String? vat;
  String? pvat;
  String? xpvat;
  String? xvat;
  String? wtax;
  String? wamt;
  String? nwht;
  String? wht;
  String? total;
  String? disendbill;
  String? diffx;
  String? dtypex;
  String? dtype;
  String? paid;
  String? refund;
  String? returnSt;
  String? asset;
  String? pass;
  String? datepass;
  String? remark;

  String? ovalue;
  String? nvalue;
  String? qty;
  String? pri;
  String? c_pvat;
  String? c_nvat;
  String? c_vat;
  String? c_amt;
  String? c_refno;
  String? c_note;

  String? ser_in;
  String? docno_in;

  String? unit_con;
  String? qty_con;
  String? amt_con;
  String? img;
  String? ucost;

  TransPakanModel(
      {this.ser,
      this.datex,
      this.timex,
      this.user,
      this.rser,
      this.daterec,
      this.timerec,
      this.date,
      this.dateacc,
      this.duedate,
      this.dateCheckin,
      this.dateCheckout,
      this.shopno,
      this.pos,
      this.shifts,
      this.st,
      this.dochtax,
      this.doctax,
      this.cid,
      this.meter,
      this.docno,
      this.custno,
      this.supno,
      this.supnox,
      this.refno,
      this.refnox,
      this.po,
      this.inv,
      this.accode,
      this.accodeAccrued,
      this.service,
      this.expense,
      this.xxxno,
      this.xxxdate,
      this.barcode,
      this.stcode,
      this.name,
      this.namex,
      this.unit,
      this.no,
      this.tqty,
      this.qty1,
      this.qty2,
      this.qty3,
      this.qty4,
      this.qty5,
      this.agqty,
      this.emp,
      this.distype,
      this.dis,
      this.discount,
      this.deposit,
      this.other,
      this.fine,
      this.expser,
      this.expname,
      this.term,
      this.sdate,
      this.ldate,
      this.amt,
      this.amtx,
      this.vtype,
      this.nvat,
      this.tax,
      this.vat,
      this.pvat,
      this.xpvat,
      this.xvat,
      this.wtax,
      this.wamt,
      this.nwht,
      this.wht,
      this.total,
      this.disendbill,
      this.diffx,
      this.dtypex,
      this.dtype,
      this.paid,
      this.refund,
      this.returnSt,
      this.asset,
      this.pass,
      this.datepass,
      this.remark,
      this.ovalue,
      this.nvalue,
      this.qty,
      this.pri,
      this.c_pvat,
      this.c_nvat,
      this.c_vat,
      this.c_amt,
      this.c_refno,
      this.c_note,
      this.ser_in,
      this.docno_in,
      this.unit_con,
      this.qty_con,
      this.img,
      this.amt_con,
      this.ucost});

  TransPakanModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    user = json['user'];
    rser = json['rser'];
    daterec = json['daterec'];
    timerec = json['timerec'];
    date = json['date'];
    dateacc = json['dateacc'];
    duedate = json['duedate'];
    dateCheckin = json['date_checkin'];
    dateCheckout = json['date_checkout'];
    shopno = json['shopno'];
    pos = json['pos'];
    shifts = json['shifts'];
    st = json['st'];
    dochtax = json['dochtax'];
    doctax = json['doctax'];
    cid = json['cid'];
    meter = json['meter'];
    docno = json['docno'];
    custno = json['custno'];
    supno = json['supno'];
    supnox = json['supnox'];
    refno = json['refno'];
    refnox = json['refnox'];
    po = json['po'];
    inv = json['inv'];
    accode = json['accode'];
    accodeAccrued = json['accode_accrued'];
    service = json['service'];
    expense = json['expense'];
    xxxno = json['xxxno'];
    xxxdate = json['xxxdate'];
    barcode = json['barcode'];
    stcode = json['stcode'];
    name = json['name'];
    namex = json['namex'];
    unit = json['unit'];
    no = json['no'];
    tqty = json['tqty'];
    qty1 = json['qty1'];
    qty2 = json['qty2'];
    qty3 = json['qty3'];
    qty4 = json['qty4'];
    qty5 = json['qty5'];
    agqty = json['agqty'];
    emp = json['emp'];
    distype = json['distype'];
    dis = json['dis'];
    discount = json['discount'];
    deposit = json['deposit'];
    other = json['other'];
    fine = json['fine'];
    expser = json['expser'];
    expname = json['expname'];
    term = json['term'];
    sdate = json['sdate'];
    ldate = json['ldate'];
    amt = json['amt'];
    amtx = json['amtx'];
    vtype = json['vtype'];
    nvat = json['nvat'];
    tax = json['tax'];
    vat = json['vat'];
    pvat = json['pvat'];
    xpvat = json['xpvat'];
    xvat = json['xvat'];
    wtax = json['wtax'];
    wamt = json['wamt'];
    nwht = json['nwht'];
    wht = json['wht'];
    total = json['total'];
    disendbill = json['disendbill'];
    diffx = json['diffx'];
    dtypex = json['dtypex'];
    dtype = json['dtype'];
    paid = json['paid'];
    refund = json['refund'];
    returnSt = json['return_st'];
    asset = json['asset'];
    pass = json['pass'];
    datepass = json['datepass'];
    remark = json['remark'];

    ovalue = json['ovalue'];
    nvalue = json['nvalue'];
    qty = json['qty'];
    pri = json['pri'];
    c_pvat = json['c_pvat'];
    c_nvat = json['c_nvat'];
    c_vat = json['c_vat'];
    c_amt = json['c_amt'];
    c_refno = json['c_refno'];
    c_note = json['c_note'];
    ser_in = json['ser_in'];
    docno_in = json['docno_in'];
    unit_con = json['unit_con'];
    qty_con = json['qty_con'];
    amt_con = json['amt_con'];
    img = json['img'];
    ucost= json['ucost'];
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
    data['duedate'] = this.duedate;
    data['date_checkin'] = this.dateCheckin;
    data['date_checkout'] = this.dateCheckout;
    data['shopno'] = this.shopno;
    data['pos'] = this.pos;
    data['shifts'] = this.shifts;
    data['st'] = this.st;
    data['dochtax'] = this.dochtax;
    data['doctax'] = this.doctax;
    data['cid'] = this.cid;
    data['meter'] = this.meter;
    data['docno'] = this.docno;
    data['custno'] = this.custno;
    data['supno'] = this.supno;
    data['supnox'] = this.supnox;
    data['refno'] = this.refno;
    data['refnox'] = this.refnox;
    data['po'] = this.po;
    data['inv'] = this.inv;
    data['accode'] = this.accode;
    data['accode_accrued'] = this.accodeAccrued;
    data['service'] = this.service;
    data['expense'] = this.expense;
    data['xxxno'] = this.xxxno;
    data['xxxdate'] = this.xxxdate;
    data['barcode'] = this.barcode;
    data['stcode'] = this.stcode;
    data['name'] = this.name;
    data['namex'] = this.namex;
    data['unit'] = this.unit;
    data['no'] = this.no;
    data['tqty'] = this.tqty;
    data['qty1'] = this.qty1;
    data['qty2'] = this.qty2;
    data['qty3'] = this.qty3;
    data['qty4'] = this.qty4;
    data['qty5'] = this.qty5;
    data['agqty'] = this.agqty;
    data['emp'] = this.emp;
    data['distype'] = this.distype;
    data['dis'] = this.dis;
    data['discount'] = this.discount;
    data['deposit'] = this.deposit;
    data['other'] = this.other;
    data['fine'] = this.fine;
    data['expser'] = this.expser;
    data['expname'] = this.expname;
    data['term'] = this.term;
    data['sdate'] = this.sdate;
    data['ldate'] = this.ldate;
    data['amt'] = this.amt;
    data['amtx'] = this.amtx;
    data['vtype'] = this.vtype;
    data['nvat'] = this.nvat;
    data['tax'] = this.tax;
    data['vat'] = this.vat;
    data['pvat'] = this.pvat;
    data['xpvat'] = this.xpvat;
    data['xvat'] = this.xvat;
    data['wtax'] = this.wtax;
    data['wamt'] = this.wamt;
    data['nwht'] = this.nwht;
    data['wht'] = this.wht;
    data['total'] = this.total;
    data['disendbill'] = this.disendbill;
    data['diffx'] = this.diffx;
    data['dtypex'] = this.dtypex;
    data['dtype'] = this.dtype;
    data['paid'] = this.paid;
    data['refund'] = this.refund;
    data['return_st'] = this.returnSt;
    data['asset'] = this.asset;
    data['pass'] = this.pass;
    data['datepass'] = this.datepass;
    data['remark'] = this.remark;

    data['ovalue'] = this.ovalue;
    data['nvalue'] = this.nvalue;
    data['qty'] = this.qty;
    data['pri'] = this.pri;
    data['c_pvat'] = this.c_pvat;
    data['c_nvat'] = this.c_nvat;
    data['c_vat'] = this.c_vat;
    data['c_amt'] = this.c_amt;
    data['c_refno'] = this.c_refno;
    data['c_note'] = this.c_note;
    data['ser_in'] = this.ser_in;
    data['docno_in'] = this.docno_in;
    data['unit_con'] = this.unit_con;
    data['qty_con'] = this.qty_con;
    data['amt_con'] = this.amt_con;
    data['img'] = this.img;
       data['ucost'] = this.ucost;
    return data;
  }
}
