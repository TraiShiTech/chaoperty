class Overdue_floorplansModel {
  String? ser;
  String? custno;
  String? dtype;
  String? date;
  String? total;
  String? refno;
  String? lncode;
  String? ln;
  String? no;
  String? sname;
  String? zn;
  String? zser;
  String? ln_c;
  String? in_docno;
  String? docno;
  String? ser_docno;
  String? quantity;
  String? id;
  String? path;
  String? color;
  String? name;
  String? ser_area;
  String? cid;

  Overdue_floorplansModel(
      {this.ser,
      this.custno,
      this.dtype,
      this.date,
      this.total,
      this.refno,
      this.lncode,
      this.ln,
      this.no,
      this.sname,
      this.zn,
      this.zser,
      this.ln_c,
      this.in_docno,
      this.docno,
      this.ser_docno,
      this.quantity,
      this.id,
      this.path,
      this.color,
      this.name,
      this.ser_area,
      this.cid});

  Overdue_floorplansModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    custno = json['custno'];
    dtype = json['dtype'];
    date = json['date'];
    total = json['total'];
    refno = json['refno'];
    lncode = json['lncode'];
    ln = json['ln'];
    no = json['no'];
    sname = json['sname'];
    zn = json['zn'];
    zser = json['.zser'];
    ln_c = json['ln_c'];
    in_docno = json['in_docno'];
    docno = json['docno'];
    ser_docno = json['ser_docno'];
    quantity = json['quantity'];
    id = json['id'];
    path = json['path'];
    color = json['color'];
    name = json['name'];
    ser_area = json['ser_area'];
    cid = json['cid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['custno'] = this.custno;
    data['dtype'] = this.dtype;
    data['date'] = this.date;
    data['total'] = this.total;
    data['refno'] = this.refno;
    data['lncode'] = this.lncode;
    data['ln'] = this.ln;
    data['no'] = this.no;
    data['sname'] = this.sname;
    data['zn'] = this.zn;
    data['.zser'] = this.zser;
    data['ln_c'] = this.ln_c;
    data['in_docno'] = this.in_docno;
    data['docno'] = this.docno;
    data['ser_docno'] = this.ser_docno;
    data['quantity'] = this.quantity;
    data['id'] = this.id;
    data['path'] = this.path;
    data['color'] = this.color;
    data['name'] = this.name;
    data['ser_area'] = this.ser_area;
    data['cid'] = this.cid;
    return data;
  }
}
