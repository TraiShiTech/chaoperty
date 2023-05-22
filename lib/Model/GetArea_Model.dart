class AreaModel {
  String? ser;
  String? rser;
  String? zser;
  String? lncode;
  String? ln;
  String? area;
  String? rent;
  String? st;
  String? img;
  String? data_update;
  String? quantity;
  String? ldate;
  String? cid;
  String? total;
  String? ln_c;
  String? area_c;
  String? docno;
  String? ln_q;
  String? ldate_q;
  String? area_q;
  String? total_q;
  String? sname;
  String? sname_q;
  String? cname;
  String? cname_q;
  String? custno;
  String? zn;

  AreaModel(
      {this.ser,
      this.rser,
      this.zser,
      this.lncode,
      this.ln,
      this.area,
      this.rent,
      this.st,
      this.img,
      this.data_update,
      this.quantity,
      this.ldate,
      this.cid,
      this.total,
      this.ln_c,
      this.area_c,
      this.docno,
      this.ln_q,
      this.ldate_q,
      this.area_q,
      this.total_q,
      this.sname,
      this.sname_q,
      this.cname,
      this.cname_q,
      this.custno,
      this.zn});

  AreaModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    rser = json['rser'];
    zser = json['zser'];
    lncode = json['lncode'];
    ln = json['ln'];
    area = json['area'];
    rent = json['rent'];
    st = json['st'];
    img = json['img'];
    data_update = json['data_update'];
    quantity = json['quantity'];
    ldate = json['ldate'];
    cid = json['cid'];
    total = json['total'];
    ln_c = json['ln_c'];
    area_c = json['area_c'];
    docno = json['docno'];
    ln_q = json['ln_q'];
    ldate_q = json['ldate_q'];
    area_q = json['area_q'];
    total_q = json['total_q'];
    sname = json['sname'];
    sname_q = json['sname_q'];
    cname = json['cname'];
    cname_q = json['cname_q'];
    custno = json['custno'];
    zn= json['zn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['rser'] = this.rser;
    data['zser'] = this.zser;
    data['lncode'] = this.lncode;
    data['ln'] = this.ln;
    data['area'] = this.area;
    data['rent'] = this.rent;
    data['st'] = this.st;
    data['img'] = this.img;
    data['data_update'] = this.data_update;
    data['quantity'] = this.quantity;
    data['ldate'] = this.ldate;
    data['cid'] = this.cid;
    data['total'] = this.total;
    data['ln_c'] = this.ln_c;
    data['area_c'] = this.area_c;
    data['docno'] = this.docno;
    data['ln_q'] = this.ln_q;
    data['ldate_q'] = this.ldate_q;
    data['area_q'] = this.area_q;
    data['total_q'] = this.total_q;
    data['sname'] = this.sname;
    data['sname_q'] = this.sname_q;
    data['cname'] = this.cname;
    data['cname_q'] = this.cname_q;
    data['custno'] = this.custno;
    data['zn'] = this.zn;
    return data;
  }
}
