class DeptModel {
  String? ser;
  String? user;
  String? rser;
  String? docno;
  String? refno;
  String? dtype;
  String? dname;
  String? qty;
  String? unit;
  String? pri;
  String? amt;
  String? vat;
  String? wht;
  String? inc;
  String? dec;
  String? total;
  String? pser;
  String? pat_time;
  String? pay_date;
  String? img;
  String? data_update;

  DeptModel(
      {this.ser,
      this.user,
      this.rser,
      this.docno,
      this.refno,
      this.dtype,
      this.dname,
      this.qty,
      this.unit,
      this.pri,
      this.amt,
      this.vat,
      this.wht,
      this.inc,
      this.dec,
      this.total,
      this.pser,
      this.pat_time,
      this.pay_date,
      this.img,
      this.data_update});

  DeptModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    user = json['user'];
    rser = json['rser'];
    docno = json['docno'];
    refno = json['refno'];
    dtype = json['dtype'];
    dname = json['dname'];
    qty = json['qty'];
    unit = json['unit'];
    pri = json['pri'];
    amt = json['amt'];
    vat = json['vat'];
    wht = json['wht'];
    inc = json['inc'];
    dec = json['dec'];
    total = json['total'];
    pser = json['pser'];
    pat_time = json['pat_time'];
    pay_date = json['pay_date'];
    img = json['img'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['user'] = this.user;
    data['rser'] = this.rser;
    data['docno'] = this.docno;
    data['refno'] = this.refno;
    data['dtype'] = this.dtype;
    data['dname'] = this.dname;
    data['qty'] = this.qty;
    data['unit'] = this.unit;
    data['pri'] = this.pri;
    data['amt'] = this.amt;
    data['vat'] = this.vat;
    data['wht'] = this.wht;
    data['inc'] = this.inc;
    data['dec'] = this.dec;
    data['total'] = this.total;
    data['pser'] = this.pser;
    data['pat_time'] = this.pat_time;
    data['pay_date'] = this.pay_date;
    data['img'] = this.img;
    data['data_update'] = this.data_update;
    return data;
  }
}
