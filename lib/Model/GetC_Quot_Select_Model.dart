class QuotxSelectModel {
  String? ser;
  String? datex;
  String? qser;
  String? docno;
  String? expser;
  String? expname;
  String? exptser;
  String? sunit;
  String? unit;
  String? day;
  String? sday;
  String? term;
  String? sdate;
  String? meter;
  String? qty;
  String? ldate;
  String? amt;
  String? vtype;
  String? nvat;
  String? vat;
  String? pvat;
  String? nwht;
  String? wht;
  String? fine;
  String? fineUnit;
  String? fineLate;
  String? fineCal;
  String? finePri;
  String? st;
  String? total;
  String? dataUpdate;
  String? dtype;

  QuotxSelectModel(
      {this.ser,
      this.datex,
      this.qser,
      this.docno,
      this.expser,
      this.expname,
      this.exptser,
      this.sunit,
      this.unit,
      this.day,
      this.sday,
      this.term,
      this.sdate,
      this.meter,
      this.qty,
      this.ldate,
      this.amt,
      this.vtype,
      this.nvat,
      this.vat,
      this.pvat,
      this.nwht,
      this.wht,
      this.fine,
      this.fineUnit,
      this.fineLate,
      this.fineCal,
      this.finePri,
      this.st,
      this.total,
      this.dataUpdate,
      this.dtype});

  QuotxSelectModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    qser = json['qser'];
    docno = json['docno'];
    expser = json['expser'];
    expname = json['expname'];
    exptser = json['exptser'];
    sunit = json['sunit'];
    unit = json['unit'];
    day = json['day'];
    sday = json['sday'];
    term = json['term'];
    sdate = json['sdate'];
    meter = json['meter'];
    qty = json['qty'];
    ldate = json['ldate'];
    amt = json['amt'];
    vtype = json['vtype'];
    nvat = json['nvat'];
    vat = json['vat'];
    pvat = json['pvat'];
    nwht = json['nwht'];
    wht = json['wht'];
    fine = json['fine'];
    fineUnit = json['fine_unit'];
    fineLate = json['fine_late'];
    fineCal = json['fine_cal'];
    finePri = json['fine_pri'];
    st = json['st'];
    total = json['total'];
    dataUpdate = json['data_update'];
    dtype = json['dtype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['qser'] = this.qser;
    data['docno'] = this.docno;
    data['expser'] = this.expser;
    data['expname'] = this.expname;
    data['exptser'] = this.exptser;
    data['sunit'] = this.sunit;
    data['unit'] = this.unit;
    data['day'] = this.day;
    data['sday'] = this.sday;
    data['term'] = this.term;
    data['sdate'] = this.sdate;
    data['meter'] = this.meter;
    data['qty'] = this.qty;
    data['ldate'] = this.ldate;
    data['amt'] = this.amt;
    data['vtype'] = this.vtype;
    data['nvat'] = this.nvat;
    data['vat'] = this.vat;
    data['pvat'] = this.pvat;
    data['nwht'] = this.nwht;
    data['wht'] = this.wht;
    data['fine'] = this.fine;
    data['fine_unit'] = this.fineUnit;
    data['fine_late'] = this.fineLate;
    data['fine_cal'] = this.fineCal;
    data['fine_pri'] = this.finePri;
    data['st'] = this.st;
    data['total'] = this.total;
    data['data_update'] = this.dataUpdate;
    data['dtype'] = this.dtype;
    return data;
  }
}
