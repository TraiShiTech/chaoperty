class TransPlayModel {
  String? ser;
  String? datex;
  String? timex;
  String? daterec;
  String? user;
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
  String? ser_trans;
  String? date_trans;
  String? docno_trans;
  String? refno_trans;
  String? name_trans;
  String? expname_trans;
  String? vat_trans;
  String? pvat_trans;
  String? wht_trans;
  String? nwht_trans;
  String? total_trans;
  String? amt_trans;
  String? expx_row;
  List<dynamic> play_amt = [];
  String? trans_date;
  String? yon_amt;


  TransPlayModel({
    this.ser,
    this.datex,
    this.timex,
    this.daterec,
    this.user,
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
    this.ser_trans,
    this.date_trans,
    this.docno_trans,
    this.refno_trans,
    this.name_trans,
    this.expname_trans,
    this.vat_trans,
    this.pvat_trans,
    this.wht_trans,
    this.nwht_trans,
    this.total_trans,
    this.amt_trans,
    this.expx_row,
    required this.play_amt,
    this.trans_date,
    this.yon_amt,
  });

  TransPlayModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    daterec = json['daterec'];
    user = json['user'];
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
    ser_trans = json['ser_trans'];
    date_trans = json['date_trans'];
    docno_trans = json['docno_trans'];
    refno_trans = json['refno_trans'];
    name_trans = json['name_trans'];
    expname_trans = json['expname_trans'];
    vat_trans = json['vat_trans'];
    pvat_trans = json['pvat_trans'];
    wht_trans = json['wht_trans'];
    nwht_trans = json['nwht_trans'];
    total_trans = json['total_trans'];
    amt_trans = json['amt_trans'];
    expx_row = json['expx_row'];
    play_amt = json['play_amt'];
    trans_date = json['trans_date'];
    yon_amt= json['yon_amt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['daterec'] = this.daterec;
    data['user'] = this.user;
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
    data['ser_trans'] = this.ser_trans;
    data['date_trans'] = this.date_trans;
    data['docno_trans'] = this.docno_trans;
    data['refno_trans'] = this.refno_trans;
    data['name_trans'] = this.name_trans;
    data['expname_trans'] = this.expname_trans;
    data['vat_trans'] = this.vat_trans;
    data['pvat_trans'] = this.pvat_trans;
    data['wht_trans'] = this.wht_trans;
    data['nwht_trans'] = this.nwht_trans;
    data['total_trans'] = this.total_trans;
    data['amt_trans'] = this.amt_trans;
    data['expx_row'] = this.expx_row;
    data['play_amt'] = this.play_amt;
    data['trans_date'] = this.trans_date;
    data['yon_amt'] = this.yon_amt;
    
    return data;
  }
}
