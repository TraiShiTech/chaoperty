class CQuotModel {
  String? ser;
  String? datex;
  String? timex;
  String? user;
  String? rser;
  String? yearx;
  String? docno;
  String? cid;
  String? fid;
  String? renewCid;
  String? xmark;
  String? paid;
  String? st;
  String? stx;
  String? renew;
  String? renewSt;
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
  String? period;
  String? nday;
  String? tser;
  String? custno;
  String? ctype;
  String? scname;
  String? sname;
  String? stype;
  String? cname;
  String? attn;
  String? addr;
  String? addrx;
  String? tax;
  String? tel;
  String? email;
  String? lineid;
  String? note;
  String? pgroup;
  String? pgoods;
  String? carno;
  String? typex;
  String? vat;
  String? zser;
  String? zn;
  String? aser;
  String? ln;
  String? ptime;
  String? ptimex;
  String? qty;
  String? area;
  String? rtser;
  String? rtname;
  String? priceChange;
  String? priceAdvance;
  String? price;
  String? pday;
  String? electricityType;
  String? electricity;
  String? electricityX;
  String? waterType;
  String? water;
  String? waterX;
  String? vtax;
  String? vtaxAmt;
  String? other;
  String? yearly;
  String? damage;
  String? furniture;
  String? damageFur;
  String? pservice;
  String? damageService;
  String? wtax;
  String? picTenant;
  String? picShop;
  String? picPlan;
  String? ccDate;
  String? ccRemark;
  String? wtaxAdvance;
  String? wtaxRental;
  String? wtaxCommonfee;
  String? wtaxBuilding;
  String? wtaxUtility;
  String? w1;
  String? w2;
  String? w3;
  String? wnote;
  String? centerx;
  String? otherx;
  String? dataUpdate;

  CQuotModel(
      {this.ser,
      this.datex,
      this.timex,
      this.user,
      this.rser,
      this.yearx,
      this.docno,
      this.cid,
      this.fid,
      this.renewCid,
      this.xmark,
      this.paid,
      this.st,
      this.stx,
      this.renew,
      this.renewSt,
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
      this.period,
      this.nday,
      this.tser,
      this.custno,
      this.ctype,
      this.scname,
      this.sname,
      this.stype,
      this.cname,
      this.attn,
      this.addr,
      this.addrx,
      this.tax,
      this.tel,
      this.email,
      this.lineid,
      this.note,
      this.pgroup,
      this.pgoods,
      this.carno,
      this.typex,
      this.vat,
      this.zser,
      this.zn,
      this.aser,
      this.ln,
      this.ptime,
      this.ptimex,
      this.qty,
      this.area,
      this.rtser,
      this.rtname,
      this.priceChange,
      this.priceAdvance,
      this.price,
      this.pday,
      this.electricityType,
      this.electricity,
      this.electricityX,
      this.waterType,
      this.water,
      this.waterX,
      this.vtax,
      this.vtaxAmt,
      this.other,
      this.yearly,
      this.damage,
      this.furniture,
      this.damageFur,
      this.pservice,
      this.damageService,
      this.wtax,
      this.picTenant,
      this.picShop,
      this.picPlan,
      this.ccDate,
      this.ccRemark,
      this.wtaxAdvance,
      this.wtaxRental,
      this.wtaxCommonfee,
      this.wtaxBuilding,
      this.wtaxUtility,
      this.w1,
      this.w2,
      this.w3,
      this.wnote,
      this.centerx,
      this.otherx,
      this.dataUpdate});

  CQuotModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    user = json['user'];
    rser = json['rser'];
    yearx = json['yearx'];
    docno = json['docno'];
    cid = json['cid'];
    fid = json['fid'];
    renewCid = json['renew_cid'];
    xmark = json['xmark'];
    paid = json['paid'];
    st = json['st'];
    stx = json['stx'];
    renew = json['renew'];
    renewSt = json['renew_st'];
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
    period = json['period'];
    nday = json['nday'];
    tser = json['tser'];
    custno = json['custno'];
    ctype = json['ctype'];
    scname = json['scname'];
    sname = json['sname'];
    stype = json['stype'];
    cname = json['cname'];
    attn = json['attn'];
    addr = json['addr'];
    addrx = json['addrx'];
    tax = json['tax'];
    tel = json['tel'];
    email = json['email'];
    lineid = json['lineid'];
    note = json['note'];
    pgroup = json['pgroup'];
    pgoods = json['pgoods'];
    carno = json['carno'];
    typex = json['typex'];
    vat = json['vat'];
    zser = json['zser'];
    zn = json['zn'];
    aser = json['aser'];
    ln = json['ln'];
    ptime = json['ptime'];
    ptimex = json['ptimex'];
    qty = json['qty'];
    area = json['area'];
    rtser = json['rtser'];
    rtname = json['rtname'];
    priceChange = json['price_change'];
    priceAdvance = json['price_advance'];
    price = json['price'];
    pday = json['pday'];
    electricityType = json['electricity_type'];
    electricity = json['electricity'];
    electricityX = json['electricity_x'];
    waterType = json['water_type'];
    water = json['water'];
    waterX = json['water_x'];
    vtax = json['vtax'];
    vtaxAmt = json['vtax_amt'];
    other = json['other'];
    yearly = json['yearly'];
    damage = json['damage'];
    furniture = json['furniture'];
    damageFur = json['damage_fur'];
    pservice = json['pservice'];
    damageService = json['damage_service'];
    wtax = json['wtax'];
    picTenant = json['pic_tenant'];
    picShop = json['pic_shop'];
    picPlan = json['pic_plan'];
    ccDate = json['cc_date'];
    ccRemark = json['cc_remark'];
    wtaxAdvance = json['wtax_advance'];
    wtaxRental = json['wtax_rental'];
    wtaxCommonfee = json['wtax_commonfee'];
    wtaxBuilding = json['wtax_building'];
    wtaxUtility = json['wtax_utility'];
    w1 = json['w1'];
    w2 = json['w2'];
    w3 = json['w3'];
    wnote = json['wnote'];
    centerx = json['centerx'];
    otherx = json['otherx'];
    dataUpdate = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['user'] = this.user;
    data['rser'] = this.rser;
    data['yearx'] = this.yearx;
    data['docno'] = this.docno;
    data['cid'] = this.cid;
    data['fid'] = this.fid;
    data['renew_cid'] = this.renewCid;
    data['xmark'] = this.xmark;
    data['paid'] = this.paid;
    data['st'] = this.st;
    data['stx'] = this.stx;
    data['renew'] = this.renew;
    data['renew_st'] = this.renewSt;
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
    data['period'] = this.period;
    data['nday'] = this.nday;
    data['tser'] = this.tser;
    data['custno'] = this.custno;
    data['ctype'] = this.ctype;
    data['scname'] = this.scname;
    data['sname'] = this.sname;
    data['stype'] = this.stype;
    data['cname'] = this.cname;
    data['attn'] = this.attn;
    data['addr'] = this.addr;
    data['addrx'] = this.addrx;
    data['tax'] = this.tax;
    data['tel'] = this.tel;
    data['email'] = this.email;
    data['lineid'] = this.lineid;
    data['note'] = this.note;
    data['pgroup'] = this.pgroup;
    data['pgoods'] = this.pgoods;
    data['carno'] = this.carno;
    data['typex'] = this.typex;
    data['vat'] = this.vat;
    data['zser'] = this.zser;
    data['zn'] = this.zn;
    data['aser'] = this.aser;
    data['ln'] = this.ln;
    data['ptime'] = this.ptime;
    data['ptimex'] = this.ptimex;
    data['qty'] = this.qty;
    data['area'] = this.area;
    data['rtser'] = this.rtser;
    data['rtname'] = this.rtname;
    data['price_change'] = this.priceChange;
    data['price_advance'] = this.priceAdvance;
    data['price'] = this.price;
    data['pday'] = this.pday;
    data['electricity_type'] = this.electricityType;
    data['electricity'] = this.electricity;
    data['electricity_x'] = this.electricityX;
    data['water_type'] = this.waterType;
    data['water'] = this.water;
    data['water_x'] = this.waterX;
    data['vtax'] = this.vtax;
    data['vtax_amt'] = this.vtaxAmt;
    data['other'] = this.other;
    data['yearly'] = this.yearly;
    data['damage'] = this.damage;
    data['furniture'] = this.furniture;
    data['damage_fur'] = this.damageFur;
    data['pservice'] = this.pservice;
    data['damage_service'] = this.damageService;
    data['wtax'] = this.wtax;
    data['pic_tenant'] = this.picTenant;
    data['pic_shop'] = this.picShop;
    data['pic_plan'] = this.picPlan;
    data['cc_date'] = this.ccDate;
    data['cc_remark'] = this.ccRemark;
    data['wtax_advance'] = this.wtaxAdvance;
    data['wtax_rental'] = this.wtaxRental;
    data['wtax_commonfee'] = this.wtaxCommonfee;
    data['wtax_building'] = this.wtaxBuilding;
    data['wtax_utility'] = this.wtaxUtility;
    data['w1'] = this.w1;
    data['w2'] = this.w2;
    data['w3'] = this.w3;
    data['wnote'] = this.wnote;
    data['centerx'] = this.centerx;
    data['otherx'] = this.otherx;
    data['data_update'] = this.dataUpdate;
    return data;
  }
}
