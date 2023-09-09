class CustomerModel {
  String? ser;
  String? user;
  String? rser;
  String? datex;
  String? timex;
  String? custno;
  String? taxno;
  String? scname;
  String? stype;
  String? tser;
  String? typeser;
  String? type;
  String? cname;
  String? branch;
  String? attn;
  String? addr1;
  String? addr2;
  String? zip;
  String? tel;
  String? tax;
  String? fax;
  String? email;
  String? lineid;
  String? lastday;
  String? status;
  String? st;
  String? dataUpdate;
  String? cid;
  String? docno;
  String? sdate;
  String? ldate;
  String? period;
  String? nday;
  String? ctype;
  String? zser;
  String? zn;
  String? aser;
  String? ln;
  String? qty;
  String? area;
  String? rtser;
  String? rtname;
  String? user_name;
  String? passw;
  String? sname;

  CustomerModel(
      {this.ser,
      this.user,
      this.rser,
      this.datex,
      this.timex,
      this.custno,
      this.taxno,
      this.scname,
      this.stype,
      this.tser,
      this.typeser,
      this.type,
      this.cname,
      this.branch,
      this.attn,
      this.addr1,
      this.addr2,
      this.zip,
      this.tel,
      this.tax,
      this.fax,
      this.email,
      this.lineid,
      this.lastday,
      this.status,
      this.st,
      this.dataUpdate,
      this.cid,
      this.docno,
      this.sdate,
      this.ldate,
      this.period,
      this.nday,
      this.ctype,
      this.zser,
      this.zn,
      this.aser,
      this.ln,
      this.qty,
      this.area,
      this.rtser,
      this.rtname,
      this.user_name,
      this.sname,
      this.passw});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    user = json['user'];
    rser = json['rser'];
    datex = json['datex'];
    timex = json['timex'];
    custno = json['custno'];
    taxno = json['taxno'];
    scname = json['scname'];
    stype = json['stype'];
    tser = json['tser'];
    typeser = json['typeser'];
    type = json['type'];
    cname = json['cname'];
    branch = json['branch'];
    attn = json['attn'];
    addr1 = json['addr_1'];
    addr2 = json['addr_2'];
    zip = json['zip'];
    tel = json['tel'];
    tax = json['tax'];
    fax = json['fax'];
    email = json['email'];
    lineid = json['lineid'];
    lastday = json['lastday'];
    status = json['status'];
    st = json['st'];
    dataUpdate = json['data_update'];
    cid = json['cid'];
    docno = json['docno'];
    sdate = json['sdate'];
    ldate = json['ldate'];
    period = json['period'];
    nday = json['nday'];
    ctype = json['ctype'];
    zser = json['zser'];
    zn = json['zn'];
    aser = json['aser'];
    ln = json['ln'];
    qty = json['qty'];
    area = json['area'];
    rtser = json['rtser'];
    rtname = json['rtname'];
    user_name = json['user_name'];
    passw = json['passw'];
    sname = json['sname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['user'] = this.user;
    data['rser'] = this.rser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['custno'] = this.custno;
    data['taxno'] = this.taxno;
    data['scname'] = this.scname;
    data['stype'] = this.stype;
    data['tser'] = this.tser;
    data['typeser'] = this.typeser;
    data['type'] = this.type;
    data['cname'] = this.cname;
    data['branch'] = this.branch;
    data['attn'] = this.attn;
    data['addr_1'] = this.addr1;
    data['addr_2'] = this.addr2;
    data['zip'] = this.zip;
    data['tel'] = this.tel;
    data['tax'] = this.tax;
    data['fax'] = this.fax;
    data['email'] = this.email;
    data['lineid'] = this.lineid;
    data['lastday'] = this.lastday;
    data['status'] = this.status;
    data['st'] = this.st;
    data['data_update'] = this.dataUpdate;
    data['cid'] = this.cid;
    data['docno'] = this.docno;
    data['sdate'] = this.sdate;
    data['ldate'] = this.ldate;
    data['period'] = this.period;
    data['nday'] = this.nday;
    data['ctype'] = this.ctype;
    data['zser'] = this.zser;
    data['zn'] = this.zn;
    data['aser'] = this.aser;
    data['ln'] = this.ln;
    data['qty'] = this.qty;
    data['area'] = this.area;
    data['rtser'] = this.rtser;
    data['rtname'] = this.rtname;
    data['user_name'] = this.user_name;
    data['passw'] = this.passw;
    data['sname'] = this.sname;
    return data;
  }
}
