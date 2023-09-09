class ContractRownumModel {
  String? ser;
  String? datex;
  String? timex;
  String? daterec;
  String? user;
  String? sw;
  String? rser;
  String? cid;
  String? fid;
  String? quot;
  String? tser;
  String? tno;
  String? ctype;
  String? sname;
  String? stype;
  String? tname;
  String? attn;
  String? addr;
  String? addrx;
  String? tax;
  String? tel;
  String? email;
  String? zser;
  String? zn;
  String? aser;
  String? lncode;
  String? ln;
  String? qty;
  String? area;
  String? rtser;
  String? rtname;
  String? sdate;
  String? ldate;
  String? period;
  String? nday;
  String? st;
  String? stx;
  String? renew_cid;
  String? remark;
  String? data_update;
  String? cc_remark;

  ContractRownumModel({
    this.ser,
    this.datex,
    this.timex,
    this.daterec,
    this.user,
    this.sw,
    this.rser,
    this.cid,
    this.fid,
    this.quot,
    this.tser,
    this.tno,
    this.ctype,
    this.sname,
    this.stype,
    this.tname,
    this.attn,
    this.addr,
    this.addrx,
    this.tax,
    this.tel,
    this.email,
    this.zn,
    this.aser,
    this.lncode,
    this.ln,
    this.qty,
    this.area,
    this.rtser,
    this.rtname,
    this.sdate,
    this.ldate,
    this.period,
    this.nday,
    this.st,
    this.stx,
    this.renew_cid,
    this.remark,
    this.data_update,
    this.cc_remark,
  });

  ContractRownumModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    daterec = json['daterec'];
    user = json['user'];
    sw = json['sw'];
    rser = json['rser'];
    cid = json['cid'];
    fid = json['fid'];
    quot = json['quot'];
    tser = json['tser'];
    tno = json['tno'];
    ctype = json['ctype'];
    sname = json['sname'];
    stype = json['stype'];
    tname = json['tname'];
    attn = json['attn'];
    addr = json['addr'];
    addrx = json['addrx'];
    tax = json['tax'];
    tel = json['tel'];
    email = json['email'];
    zser = json['zser'];
    zn = json['zn'];
    aser = json['aser'];
    lncode = json['lncode'];
    ln = json['ln'];
    qty = json['qty'];
    area = json['area'];
    rtser = json['rtser'];
    rtname = json['rtname'];
    sdate = json['sdate'];
    ldate = json['ldate'];
    period = json['period'];
    nday = json['nday'];
    st = json['st'];
    stx = json['stx'];
    renew_cid = json['renew_cid'];
    remark = json['remark'];
    data_update = json['data_update'];
    cc_remark = json['cc_remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['daterec'] = this.daterec;
    data['user'] = this.user;
    data['sw'] = this.sw;
    data['rser'] = this.rser;
    data['cid'] = this.cid;
    data['fid'] = this.fid;
    data['quot'] = this.quot;
    data['tser'] = this.tser;
    data['tno'] = this.tno;
    data['ctype'] = this.ctype;
    data['sname'] = this.sname;
    data['stype'] = this.stype;
    data['tname'] = this.tname;
    data['attn'] = this.attn;
    data['addr'] = this.addr;
    data['addrx'] = this.addrx;
    data['tax'] = this.tax;
    data['tel'] = this.tel;
    data['email'] = this.email;
    data['zser'] = this.zser;
    data['zn'] = this.zn;
    data['aser'] = this.aser;
    data['lncode'] = this.lncode;
    data['ln'] = this.ln;
    data['qty'] = this.qty;
    data['area'] = this.area;
    data['rtser'] = this.rtser;
    data['rtname'] = this.rtname;
    data['sdate'] = this.sdate;
    data['ldate'] = this.ldate;
    data['period'] = this.period;
    data['nday'] = this.nday;
    data['st'] = this.st;
    data['stx'] = this.stx;
    data['renew_cid'] = this.renew_cid;
    data['remark'] = this.remark;
    data['data_update'] = this.data_update;
    data['cc_remark'] = this.cc_remark;
    return data;
  }
}
