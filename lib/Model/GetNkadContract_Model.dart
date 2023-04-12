class NkadContractModel {
  String? ser;
  String? yearx;
  String? cid;
  String? fid;
  String? renew_cid;
  String? xmark;
  String? paid;
  String? st;
  String? stx;
  String? renew;
  String? renew_st;
  String? daterec;
  String? datesale;
  String? d1;
  String? d2;
  String? d3;
  String? d4;
  String? d5;
  String? d6;
  String? d7;
  String? sdate;
  String? ldate;
  String? nday;
  String? tser;
  String? custno;
  String? ctype;
  String? tname;
  String? addr;
  String? tax;
  String? tel;
  String? email;
  String? lineid;
  String? note;
  String? pgroup;
  String? pgoods;
  String? carno;
  String? typex;
  String? zser;
  String? zn;
  String? ln;
  String? ptime;
  String? ptimex;
  String? qty;
  String? price_change;
  String? price_advance;
  String? price;
  String? pday;
  String? electricity_type;
  String? electricity;
  String? electricity_x;
  String? water_type;
  String? water;
  String? water_x;
  String? vtax;
  String? vtax_amt;
  String? other;
  String? yearly;
  String? damage;
  String? wtax;
  String? pic_tenant;
  String? pic_shop;
  String? pic_plan;
  String? cc_date;
  String? cc_remark;
  String? wtax_advance;
  String? wtax_rental;
  String? wtax_commonfee;
  String? wtax_building;
  String? wtax_utility;
  String? w1;
  String? w2;
  String? w3;
  String? wnote;

  NkadContractModel(
      {this.ser,
      this.yearx,
      this.cid,
      this.fid,
      this.renew_cid,
      this.xmark,
      this.paid,
      this.st,
      this.stx,
      this.renew,
      this.renew_st,
      this.daterec,
      this.datesale,
      this.d1,
      this.d2,
      this.d3,
      this.d4,
      this.d5,
      this.d6,
      this.d7,
      this.sdate,
      this.ldate,
      this.nday,
      this.tser,
      this.custno,
      this.ctype,
      this.tname,
      this.addr,
      this.tax,
      this.tel,
      this.email,
      this.lineid,
      this.note,
      this.pgroup,
      this.pgoods,
      this.carno,
      this.typex,
      this.zser,
      this.zn,
      this.ln,
      this.ptime,
      this.ptimex,
      this.qty,
      this.price_change,
      this.price_advance,
      this.price,
      this.pday,
      this.electricity_type,
      this.electricity,
      this.electricity_x,
      this.water_type,
      this.water,
      this.water_x,
      this.vtax,
      this.vtax_amt,
      this.other,
      this.yearly,
      this.damage,
      this.wtax,
      this.pic_tenant,
      this.pic_shop,
      this.pic_plan,
      this.cc_date,
      this.cc_remark,
      this.wtax_advance,
      this.wtax_rental,
      this.wtax_commonfee,
      this.wtax_building,
      this.wtax_utility,
      this.w1,
      this.w2,
      this.w3,
      this.wnote});

  NkadContractModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    yearx = json['yearx'];
    cid = json['cid'];
    fid = json['fid'];
    renew_cid = json['renew_cid'];
    xmark = json['xmark'];
    paid = json['paid'];
    st = json['st'];
    stx = json['stx'];
    renew = json['renew'];
    renew_st = json['renew_st'];
    daterec = json['daterec'];
    datesale = json['datesale'];
    d1 = json['d1'];
    d2 = json['d2'];
    d3 = json['d3'];
    d4 = json['d4'];
    d5 = json['d5'];
    d6 = json['d6'];
    d7 = json['d7'];
    sdate = json['sdate'];
    ldate = json['ldate'];
    nday = json['nday'];
    tser = json['tser'];
    custno = json['custno'];
    ctype = json['ctype'];
    tname = json['tname'];
    addr = json['addr'];
    tax = json['tax'];
    tel = json['tel'];
    email = json['email'];
    lineid = json['lineid'];
    note = json['note'];
    pgroup = json['pgroup'];
    pgoods = json['pgoods'];
    carno = json['carno'];
    typex = json['typex'];
    zser = json['zser'];
    zn = json['zn'];
    ln = json['ln'];
    ptime = json['ptime'];
    ptimex = json['ptimex'];
    qty = json['qty'];
    price_change = json['price_change'];
    price_advance = json['price_advance'];
    price = json['price'];
    pday = json['pday'];
    electricity_type = json['electricity_type'];
    electricity = json['electricity'];
    electricity_x = json['electricity_x'];
    water_type = json['water_type'];
    water = json['water'];
    water_x = json['water_x'];
    vtax = json['vtax'];
    vtax_amt = json['vtax_amt'];
    other = json['other'];
    yearly = json['yearly'];
    damage = json['damage'];
    wtax = json['wtax'];
    pic_tenant = json['pic_tenant'];
    pic_shop = json['pic_shop'];
    pic_plan = json['pic_plan'];
    cc_date = json['cc_date'];
    cc_remark = json['cc_remark'];
    wtax_advance = json['wtax_advance'];
    wtax_rental = json['wtax_rental'];
    wtax_commonfee = json['wtax_commonfee'];
    wtax_building = json['wtax_building'];
    wtax_utility = json['wtax_utility'];
    w1 = json['w1'];
    w2 = json['w2'];
    w3 = json['w3'];
    wnote = json['wnote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['yearx'] = this.yearx;
    data['cid'] = this.cid;
    data['fid'] = this.fid;
    data['renew_cid'] = this.renew_cid;
    data['xmark'] = this.xmark;
    data['paid'] = this.paid;
    data['st'] = this.st;
    data['stx'] = this.stx;
    data['renew'] = this.renew;
    data['renew_st'] = this.renew_st;
    data['daterec'] = this.daterec;
    data['datesale'] = this.datesale;
    data['d1'] = this.d1;
    data['d2'] = this.d2;
    data['d3'] = this.d3;
    data['d4'] = this.d4;
    data['d5'] = this.d5;
    data['d6'] = this.d6;
    data['d7'] = this.d7;
    data['sdate'] = this.sdate;
    data['ldate'] = this.ldate;
    data['nday'] = this.nday;
    data['tser'] = this.tser;
    data['custno'] = this.custno;
    data['ctype'] = this.ctype;
    data['tname'] = this.tname;
    data['addr'] = this.addr;
    data['tax'] = this.tax;
    data['tel'] = this.tel;
    data['email'] = this.email;
    data['lineid'] = this.lineid;
    data['note'] = this.note;
    data['pgroup'] = this.pgroup;
    data['pgoods'] = this.pgoods;
    data['carno'] = this.carno;
    data['typex'] = this.typex;
    data['zser'] = this.zser;
    data['zn'] = this.zn;
    data['ln'] = this.ln;
    data['ptime'] = this.ptime;
    data['ptimex'] = this.ptimex;
    data['qty'] = this.qty;
    data['price_change'] = this.price_change;
    data['price_advance'] = this.price_advance;
    data['price'] = this.price;
    data['pday'] = this.pday;
    data['electricity_type'] = this.electricity_type;
    data['electricity'] = this.electricity;
    data['electricity_x'] = this.electricity_x;
    data['water_type'] = this.water_type;
    data['water'] = this.water;
    data['water_x'] = this.water_x;
    data['vtax'] = this.vtax;
    data['vtax_amt'] = this.vtax_amt;
    data['other'] = this.other;
    data['yearly'] = this.yearly;
    data['damage'] = this.damage;
    data['wtax'] = this.wtax;
    data['pic_tenant'] = this.pic_tenant;
    data['pic_shop'] = this.pic_shop;
    data['pic_plan'] = this.pic_plan;
    data['cc_date'] = this.cc_date;
    data['cc_remark'] = this.cc_remark;
    data['wtax_advance'] = this.wtax_advance;
    data['wtax_rental'] = this.wtax_rental;
    data['wtax_commonfee'] = this.wtax_commonfee;
    data['wtax_building'] = this.wtax_building;
    data['wtax_utility'] = this.wtax_utility;
    data['w1'] = this.w1;
    data['w2'] = this.w2;
    data['w3'] = this.w3;
    data['wnote'] = this.wnote;

    return data;
  }
}
