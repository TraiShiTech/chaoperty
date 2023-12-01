class Read_DataONBill_PDFModel {
  String? ser;
  String? rser;
  String? docno;
  String? doctax;
  String? cid;
  String? datex;
  String? znn;
  String? daterec;
  String? dateacc;
  String? expname;
  String? room_number;
  String? scname;
  String? cname;
  String? addr1;
  String? tax;
  String? tel;
  String? email;
  String? stype;
  String? type;
  String? zn;
  String? ln;
  String? custno;
  String? remark;
  String? user;

  Read_DataONBill_PDFModel(
      {this.ser,
      this.rser,
      this.docno,
      this.doctax,
      this.cid,
      this.datex,
      this.znn,
      this.daterec,
      this.dateacc,
      this.expname,
      this.room_number,
      this.scname,
      this.cname,
      this.addr1,
      this.tax,
      this.tel,
      this.email,
      this.stype,
      this.type,
      this.zn,
      this.ln,
      this.custno,
      this.remark,
      this.user});

  Read_DataONBill_PDFModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    rser = json['rser'];
    docno = json['docno'];
    doctax = json['doctax'];
    cid = json['cid'];
    datex = json['datex'];
    znn = json['znn'];
    daterec = json['daterec'];
    dateacc = json['dateacc'];
    expname = json['expname'];
    room_number = json['room_number'];
    scname = json['scname'];
    cname = json['cname'];
    addr1 = json['addr_1'];
    tax = json['tax'];
    tel = json['tel'];
    email = json['email'];
    stype = json['stype'];
    type = json['type'];
    zn = json['zn'];
    ln = json['ln'];
    custno = json['custno'];
    remark = json['remark'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['rser'] = this.rser;
    data['docno'] = this.docno;
    data['doctax'] = this.doctax;
    data['cid'] = this.cid;
    data['datex'] = this.datex;
    data['znn'] = this.znn;
    data['daterec'] = this.daterec;
    data['dateacc'] = this.dateacc;
    data['expname'] = this.expname;
    data['room_number'] = this.room_number;
    data['scname'] = this.scname;
    data['cname'] = this.cname;
    data['addr_1'] = this.addr1;
    data['tax'] = this.tax;
    data['tel'] = this.tel;
    data['email'] = this.email;
    data['stype'] = this.stype;
    data['type'] = this.type;
    data['zn'] = this.zn;
    data['ln'] = this.ln;
    data['custno'] = this.custno;
    data['remark'] = this.remark;
    data['user'] = this.user;
    return data;
  }
}
