class TeNantModel {
  String? ser;
  String? datex;
  String? timex;
  String? rser;
  String? zser;
  String? lncode;
  String? ln;
  String? area;
  String? rent;
  String? st;
  String? img;
  String? tser;
  String? tname;
  String? cid;
  String? dataUpdate;
  String? total;
  String? sdate;
  String? ldate;
  String? cdate;
  String? cname;
  String? sname;
  String? ln_c;
  String? area_c;
  String? docno;
  String? date;
  String? cname_q;
  String? sname_q;
  String? ln_q;
  String? ldate_q;
  String? sdate_q;
  String? area_q;
  String? quantity;
  String? period;
  String? period_q;
  String? rtname;
  String? rtname_q;
  String? stype;
  String? attn;
  String? addr;
  String? tax;
  String? tel;
  String? email;
  String? ctype;
  String? zn;
  String? aser;
  String? qty;
  String? count_bill;
  String? invoice;
  String? expname;
  String? ser_tran;
  String? custno_1;
  String? custno_2;
  String? duedate;
  String? amt;
  String? amt_expser1;
  String? amt_expser9;
  String? amt_expser10;
  String? amt_expser11;
  String? amt_expser12;
  String? cc_remark;
  String? custno;
  String? user_name;
  String? passw;
  String? fid;
  String? renew_cid;
  String? cc_date;
  String? wnote;
  String? daterec;

  TeNantModel(
      {this.ser,
      this.datex,
      this.timex,
      this.rser,
      this.zser,
      this.lncode,
      this.ln,
      this.area,
      this.rent,
      this.st,
      this.img,
      this.tser,
      this.tname,
      this.cid,
      this.dataUpdate,
      this.total,
      this.sdate,
      this.ldate,
      this.cdate,
      this.cname,
      this.sname,
      this.ln_c,
      this.area_c,
      this.docno,
      this.date,
      this.cname_q,
      this.sname_q,
      this.ln_q,
      this.ldate_q,
      this.sdate_q,
      this.area_q,
      this.quantity,
      this.period,
      this.period_q,
      this.rtname,
      this.rtname_q,
      this.stype,
      this.attn,
      this.addr,
      this.tax,
      this.tel,
      this.email,
      this.ctype,
      this.zn,
      this.aser,
      this.qty,
      this.count_bill,
      this.invoice,
      this.expname,
      this.ser_tran,
      this.custno_1,
      this.custno_2,
      this.duedate,
      this.amt,
      this.amt_expser1,
      this.amt_expser9,
      this.amt_expser10,
      this.amt_expser11,
      this.amt_expser12,
      this.cc_remark,
      this.custno,
      this.user_name,
      this.passw,
      this.fid,
      this.renew_cid,
      this.cc_date,
      this.wnote,
      this.daterec});

  TeNantModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    rser = json['rser'];
    zser = json['zser'];
    lncode = json['lncode'];
    ln = json['ln'];
    area = json['area'];
    rent = json['rent'];
    st = json['st'];
    img = json['img'];
    tser = json['tser'];
    tname = json['tname'];
    cid = json['cid'];
    dataUpdate = json['data_update'];
    total = json['total'];
    sdate = json['sdate'];
    cdate = json['cdate'];
    ldate = json['ldate'];
    cname = json['cname'];
    sname = json['sname'];
    ln_c = json['ln_c'];
    area_c = json['area_c'];
    docno = json['docno'];
    date = json['date'];

    cname_q = json['cname_q'];
    sname_q = json['sname_q'];
    ln_q = json['ln_q'];
    ldate_q = json['ldate_q'];
    sdate_q = json['sdate_q'];
    area_q = json['area_q'];
    quantity = json['quantity'];
    period = json['period'];
    period_q = json['period_q'];
    rtname = json['rtname'];
    rtname_q = json['rtname_q'];
    stype = json['stype'];
    attn = json['attn'];
    addr = json['addr'];
    tax = json['tax'];
    tel = json['tel'];
    email = json['email'];
    ctype = json['ctype'];
    zn = json['zn'];
    aser = json['aser'];
    qty = json['qty'];
    count_bill = json['count_bill'];
    invoice = json['invoice'];
    expname = json['expname'];
    ser_tran = json['ser_tran'];

    custno_1 = json['custno_1'];
    custno_2 = json['custno_2'];
    duedate = json['duedate'];
    amt = json['amt'];

    amt_expser1 = json['amt_expser1'];
    amt_expser9 = json['amt_expser9'];
    amt_expser10 = json['amt_expser10'];
    amt_expser11 = json['amt_expser11'];
    amt_expser12 = json['amt_expser12'];
    cc_remark = json['cc_remark'];
    custno = json['custno'];
    user_name = json['user_name'];
    passw = json['passw'];
    fid = json['fid'];
    renew_cid = json['renew_cid'];
    cc_date = json['cc_date'];
    wnote = json['wnote'];
    daterec = json['daterec'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['rser'] = this.rser;
    data['zser'] = this.zser;
    data['lncode'] = this.lncode;
    data['ln'] = this.ln;
    data['area'] = this.area;
    data['rent'] = this.rent;
    data['st'] = this.st;
    data['img'] = this.img;
    data['tser'] = this.tser;
    data['tname'] = this.tname;
    data['cid'] = this.cid;
    data['data_update'] = this.dataUpdate;
    data['total'] = this.total;
    data['sdate'] = this.sdate;
    data['ldate'] = this.ldate;
    data['cdate'] = this.cdate;
    data['cname'] = this.cname;
    data['sname'] = this.sname;
    data['ln_c'] = this.ln_c;
    data['area_c'] = this.area_c;
    data['docno'] = this.docno;
    data['date'] = this.date;
    data['cname_q'] = this.cname_q;
    data['sname_q'] = this.sname_q;
    data['ln_q'] = this.ln_q;
    data['ldate_q'] = this.ldate_q;
    data['sdate_q'] = this.sdate_q;
    data['area_q'] = this.area_q;
    data['quantity'] = this.quantity;
    data['period'] = this.period;
    data['period_q'] = this.period_q;
    data['rtname'] = this.rtname;
    data['rtname_q'] = this.rtname_q;
    data['stype'] = this.stype;
    data['attn'] = this.attn;
    data['addr'] = this.addr;
    data['tax'] = this.tax;
    data['tel'] = this.tel;
    data['email'] = this.email;
    data['ctype'] = this.ctype;
    data['zn'] = this.zn;
    data['aser'] = this.aser;
    data['qty'] = this.qty;
    data['count_bill'] = this.count_bill;
    data['invoice'] = this.invoice;
    data['expname'] = this.expname;
    data['ser_tran'] = this.ser_tran;

    data['custno_1'] = this.custno_1;
    data['custno_2'] = this.custno_2;
    data['duedate'] = this.duedate;
    data['amt'] = this.amt;

    data['amt_expser1'] = this.amt_expser1;
    data['amt_expser9'] = this.amt_expser9;
    data['amt_expser10'] = this.amt_expser10;
    data['amt_expser11'] = this.amt_expser11;
    data['amt_expser12'] = this.amt_expser12;
    data['cc_remark'] = this.cc_remark;
    data['custno'] = this.custno;
    data['user_name'] = this.user_name;
    data['passw'] = this.passw;
    data['fid'] = this.fid;
    data['renew_cid'] = this.renew_cid;
    data['cc_date'] = this.cc_date;
    data['wnote'] = this.wnote;
    data['daterec'] = this.daterec;

    return data;
  }
}
