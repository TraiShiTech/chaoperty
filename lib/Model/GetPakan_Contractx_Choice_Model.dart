class ContractxPakanChoiceModel {
  String? ser;
  String? datex;
  String? timex;
  String? cser;
  String? cid;
  String? expser;
  String? exptser;
  String? expname;
  String? unitser;
  String? unit;
  String? term;
  String? sday;
  String? sdate;
  String? ldate;
  String? meter;
  String? qty;
  String? amt;
  String? vtype;
  String? nvat;
  String? vat;
  String? pvat;
  String? nwht;
  String? wht;
  String? total;
  String? st;
  String? dataUpdate;
  String? sum_total;

  String? etype;
  String? dtype;

  String? sname;
  String? cname;
  String? ctype;
  String? stype;
  String? zser;
  String? zser1;
  String? zn;
  String? ln;
  String? docno;
  String? doctax;
  String? refno;
  String? remark;
  String? room_number;
  String? name;
  String? zn1;
  String? tax;
  String? max_date;
  String? user;
  String? name_user;

  ContractxPakanChoiceModel(
      {this.ser,
      this.datex,
      this.timex,
      this.cser,
      this.cid,
      this.expser,
      this.exptser,
      this.expname,
      this.unitser,
      this.unit,
      this.term,
      this.sday,
      this.sdate,
      this.ldate,
      this.meter,
      this.qty,
      this.amt,
      this.vtype,
      this.nvat,
      this.vat,
      this.pvat,
      this.nwht,
      this.wht,
      this.total,
      this.st,
      this.sum_total,
      this.dataUpdate,
      this.etype,
      this.dtype,
      this.sname,
      this.cname,
      this.ctype,
      this.stype,
      this.zser,
      this.zser1,
      this.zn,
      this.ln,
      this.docno,
      this.doctax,
      this.refno,
      this.remark,
      this.room_number,
      this.name,
      this.zn1,
      this.tax,
      this.max_date,
      this.user,
      this.name_user});

  ContractxPakanChoiceModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    cser = json['cser'];
    cid = json['cid'];
    expser = json['expser'];
    exptser = json['exptser'];
    expname = json['expname'];
    unitser = json['unitser'];
    unit = json['unit'];
    term = json['term'];
    sday = json['sday'];
    sdate = json['sdate'];
    ldate = json['ldate'];
    meter = json['meter'];
    qty = json['qty'];
    amt = json['amt'];
    vtype = json['vtype'];
    nvat = json['nvat'];
    vat = json['vat'];
    pvat = json['pvat'];
    nwht = json['nwht'];
    wht = json['wht'];
    total = json['total'];
    st = json['st'];
    dataUpdate = json['data_update'];
    sum_total = json['sum_total'];

    etype = json['etype'];
    dtype = json['dtype'];

    sname = json['sname'];
    cname = json['cname'];
    ctype = json['ctype'];
    stype = json['stype'];
    zser = json['zser'];
    zser1 = json['zser1'];
    zn = json['zn'];
    ln = json['ln'];
    docno = json['docno'];
    doctax = json['doctax'];
    refno = json['refno'];
    remark = json['remark'];
    room_number = json['room_number'];
    name = json['name'];
    zn1 = json['zn1'];
    tax = json['tax'];
    max_date = json['max_date'];
    user = json['user'];
    name_user = json['name_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['cser'] = this.cser;
    data['cid'] = this.cid;
    data['expser'] = this.expser;
    data['exptser'] = this.exptser;
    data['expname'] = this.expname;
    data['unitser'] = this.unitser;
    data['unit'] = this.unit;
    data['term'] = this.term;
    data['sday'] = this.sday;
    data['sdate'] = this.sdate;
    data['ldate'] = this.ldate;
    data['meter'] = this.meter;
    data['qty'] = this.qty;
    data['amt'] = this.amt;
    data['vtype'] = this.vtype;
    data['nvat'] = this.nvat;
    data['vat'] = this.vat;
    data['pvat'] = this.pvat;
    data['nwht'] = this.nwht;
    data['wht'] = this.wht;
    data['total'] = this.total;
    data['st'] = this.st;
    data['data_update'] = this.dataUpdate;
    data['sum_total'] = this.sum_total;

    data['etype'] = this.etype;
    data['dtype'] = this.dtype;

    data['sname'] = this.sname;
    data['cname'] = this.cname;
    data['ctype'] = this.ctype;
    data['stype'] = this.stype;
    data['zser'] = this.zser;
    data['zser1'] = this.zser1;
    data['zn'] = this.zn;
    data['ln'] = this.ln;
    data['docno'] = this.docno;
    data['doctax'] = this.doctax;
    data['refno'] = this.refno;
    data['remark'] = this.remark;
    data['room_number'] = this.room_number;
    data['name'] = this.name;
    data['zn1'] = this.zn1;
    data['tax'] = this.tax;
    data['max_date'] = this.max_date;
    data['user'] = this.user;
    data['name_user'] = this.name_user;

    return data;
  }
}
