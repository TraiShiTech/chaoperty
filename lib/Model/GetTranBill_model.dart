class TransBillModel {
  String? ser;
  String? docno;
  String? tno;
  String? dtype;
  String? date;
  String? total;
  String? expname;
  String? invoice;
  String? descr;
  String? duedate;
  String? nvat;
  String? pvat;
  String? vat;
  String? nwht;
  String? wht;
  String? vtype;
  String? vser;
  String? meter;
  String? refno;

  TransBillModel({
    this.ser,
    this.docno,
    this.tno,
    this.dtype,
    this.date,
    this.total,
    this.expname,
    this.invoice,
    this.descr,
    this.duedate,
    this.nvat,
    this.pvat,
    this.vat,
    this.nwht,
    this.wht,
    this.vtype,
    this.vser,
    this.meter,
    this.refno,
  });

  TransBillModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    docno = json['docno'];
    tno = json['tno'];
    dtype = json['dtype'];
    date = json['date'];
    total = json['total'];
    expname = json['expname'];
    invoice = json['invoice'];
    descr = json['descr'];
    duedate = json['duedate'];
    nvat = json['nvat'];
    pvat = json['pvat'];
    vat = json['vat'];
    nwht = json['nwht'];
    wht = json['wht'];
    vtype = json['vtype'];
    vser = json['vser'];
    meter = json['meter'];
    refno = json['refno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['docno'] = this.docno;
    data['tno'] = this.tno;
    data['dtype'] = this.dtype;
    data['date'] = this.date;
    data['total'] = this.total;
    data['expname'] = this.expname;
    data['invoice'] = this.invoice;
    data['descr'] = this.descr;
    data['duedate'] = this.duedate;
    data['nvat'] = this.nvat;
    data['pvat'] = this.pvat;
    data['vat'] = this.vat;
    data['nwht'] = this.nwht;
    data['wht'] = this.wht;
    data['vtype'] = this.vtype;
    data['vser'] = this.vser;
    data['meter'] = this.meter;   data['refno'] = this.refno;

    return data;
  }
}
