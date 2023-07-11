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

  TransBillModel(
      {this.ser,
      this.docno,
      this.tno,
      this.dtype,
      this.date,
      this.total,
      this.expname,
      this.invoice,
      this.descr,
      this.duedate});

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

    return data;
  }
}
