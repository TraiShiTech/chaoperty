class TeNantRenewChoiceModel {
  String? ser;
  String? datex;
  String? timex;
  String? rser;
  String? zser;
  String? lncode;
  String? ln;
  String? area;
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
  String? doctax;
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
  String? cc_date;
  String? wnote;
  String? daterec;
  String? zser1;
  String? zn1;
  String? pdate;
  String? user;
  String? name_user;
  String? water_electri;
  String? deposit;
  String? water;
  String? electricity;
  String? fine;
  String? nday;

  String? rent_name;
  String? rent_amt;
  String? rent_pvat;
  String? rent_vat;
  String? rent_total;

  String? service_name;
  String? service_amt;
  String? service_pvat;
  String? service_vat;
  String? service_total;
  String? renew_cid;

  TeNantRenewChoiceModel({
    this.ser,
    this.datex,
    this.timex,
    this.rser,
    this.zser,
    this.lncode,
    this.ln,
    this.area,
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
    this.doctax,
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
    this.cc_date,
    this.wnote,
    this.daterec,
    this.zser1,
    this.zn1,
    this.pdate,
    this.user,
    this.name_user,
    this.water_electri,
    this.deposit,
    this.water,
    this.electricity,
    this.fine,
    this.nday,
    this.rent_name,
    this.rent_amt,
    this.rent_pvat,
    this.rent_vat,
    this.rent_total,
    this.service_name,
    this.service_amt,
    this.service_pvat,
    this.service_vat,
    this.service_total,
    this.renew_cid,
  });

  TeNantRenewChoiceModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    rser = json['rser'];
    zser = json['zser'];
    lncode = json['lncode'];
    ln = json['ln'];
    area = json['area'];
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
    doctax = json['doctax'];
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
    cc_date = json['cc_date'];
    wnote = json['wnote'];
    daterec = json['daterec'];
    zser1 = json['zser1'];
    zn1 = json['zn1'];
    pdate = json['pdate'];
    user = json['user'];
    name_user = json['name_user'];
    water_electri = json['water_electri'];
    deposit = json['deposit'];
    water = json['water'];
    electricity = json['electricity'];
    fine = json['fine'];
    nday = json['nday'];

    rent_name = json['rent_name'];
    rent_amt = json['rent_amt'];
    rent_pvat = json['rent_pvat'];
    rent_vat = json['rent_vat'];
    rent_total = json['rent_total'];
    service_name = json['service_name'];
    service_amt = json['service_amt'];
    service_pvat = json['service_pvat'];
    service_vat = json['service_vat'];
    service_total = json['service_total'];
    renew_cid = json['renew_cid'];
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
    data['doctax'] = this.doctax;
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
    data['cc_date'] = this.cc_date;
    data['wnote'] = this.wnote;
    data['daterec'] = this.daterec;
    data['zser1'] = this.zser1;
    data['zn1'] = this.zn1;
    data['pdate'] = this.pdate;
    data['user'] = this.user;
    data['name_user'] = this.name_user;

    data['water_electri'] = this.water_electri;
    data['deposit'] = this.deposit;
    data['water'] = this.water;
    data['electricity'] = this.electricity;
    data['fine'] = this.fine;
    data['nday'] = this.nday;

    data['rent_name'] = this.rent_name;
    data['rent_amt'] = this.rent_amt;
    data['rent_pvat'] = this.rent_pvat;
    data['rent_vat'] = this.rent_vat;
    data['rent_total'] = this.rent_total;
    data['service_name'] = this.service_name;
    data['service_amt'] = this.service_amt;
    data['service_pvat'] = this.service_pvat;
    data['service_vat'] = this.service_vat;
    data['service_total'] = this.service_total;
    data['renew_cid'] = this.renew_cid;

    return data;
  }
}
