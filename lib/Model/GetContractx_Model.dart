class ContractxModel {
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

  ContractxModel(
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
      this.dataUpdate});

  ContractxModel.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
