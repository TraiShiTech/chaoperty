class TransteNantModels {
  String? cid;
  String? ser;
  String? docno;
  String? refno;
  String? dtype;
  String? daterec;
  String? shopno;
  String? pos;
  String? custno;
  String? type;
  String? amt;
  String? total;
  String? total_mont1;
  String? total_mont2;
  String? total_mont3;
  String? total_mont4;
  String? total_mont5;
  String? total_mont6;
  String? total_mont7;
  String? total_mont8;
  String? total_mont9;
  String? total_mont10;
  String? total_mont11;
  String? total_mont12;

  String? l_date_m1;
  String? l_date_m2;
  String? l_date_m3;
  String? l_date_m4;
  String? l_date_m5;
  String? l_date_m6;
  String? l_date_m7;
  String? l_date_m8;
  String? l_date_m9;
  String? l_date_m10;
  String? l_date_m11;
  String? l_date_m12;

  String? l_docno_m1;
  String? l_docno_m2;
  String? l_docno_m3;
  String? l_docno_m4;
  String? l_docno_m5;
  String? l_docno_m6;
  String? l_docno_m7;
  String? l_docno_m8;
  String? l_docno_m9;
  String? l_docno_m10;
  String? l_docno_m11;
  String? l_docno_m12;

  TransteNantModels({
    this.cid,
    this.ser,
    this.docno,
    this.refno,
    this.dtype,
    this.daterec,
    this.shopno,
    this.pos,
    this.custno,
    this.type,
    this.amt,
    this.total,
    this.total_mont1,
    this.total_mont2,
    this.total_mont3,
    this.total_mont4,
    this.total_mont5,
    this.total_mont6,
    this.total_mont7,
    this.total_mont8,
    this.total_mont9,
    this.total_mont10,
    this.total_mont11,
    this.total_mont12,
    this.l_date_m1,
    this.l_date_m2,
    this.l_date_m3,
    this.l_date_m4,
    this.l_date_m5,
    this.l_date_m6,
    this.l_date_m7,
    this.l_date_m8,
    this.l_date_m9,
    this.l_date_m10,
    this.l_date_m11,
    this.l_date_m12,
    this.l_docno_m1,
    this.l_docno_m2,
    this.l_docno_m3,
    this.l_docno_m4,
    this.l_docno_m5,
    this.l_docno_m6,
    this.l_docno_m7,
    this.l_docno_m8,
    this.l_docno_m9,
    this.l_docno_m10,
    this.l_docno_m11,
    this.l_docno_m12,
  });

  TransteNantModels.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    ser = json['ser'];
    docno = json['docno'];
    refno = json['refno'];
    dtype = json['dtype'];
    daterec = json['daterec'];
    shopno = json['shopno'];
    pos = json['pos'];
    custno = json['custno'];
    type = json['type'];
    amt = json['amt'];
    total = json['total'];
    total_mont1 = json['total_mont1'];
    total_mont2 = json['total_mont2'];
    total_mont3 = json['total_mont3'];
    total_mont4 = json['total_mont4'];
    total_mont5 = json['total_mont5'];
    total_mont6 = json['total_mont6'];
    total_mont7 = json['total_mont7'];
    total_mont8 = json['total_mont8'];
    total_mont9 = json['total_mont9'];
    total_mont10 = json['total_mont10'];
    total_mont11 = json['total_mont11'];
    total_mont12 = json['total_mont12'];

    l_date_m1 = json['l_date_m1'];
    l_date_m2 = json['l_date_m2'];
    l_date_m3 = json['l_date_m3'];
    l_date_m4 = json['l_date_m4'];
    l_date_m5 = json['l_date_m5'];
    l_date_m6 = json['l_date_m6'];
    l_date_m7 = json['l_date_m7'];
    l_date_m8 = json['l_date_m8'];
    l_date_m9 = json['l_date_m9'];
    l_date_m10 = json['l_date_m10'];
    l_date_m11 = json['l_date_m11'];
    l_date_m12 = json['l_date_m12'];

    l_docno_m1 = json['l_docno_m1'];
    l_docno_m2 = json['l_docno_m2'];
    l_docno_m3 = json['l_docno_m3'];
    l_docno_m4 = json['l_docno_m4'];
    l_docno_m5 = json['l_docno_m5'];
    l_docno_m6 = json['l_docno_m6'];
    l_docno_m7 = json['l_docno_m7'];
    l_docno_m8 = json['l_docno_m8'];
    l_docno_m9 = json['l_docno_m9'];
    l_docno_m10 = json['l_docno_m10'];
    l_docno_m11 = json['l_docno_m11'];
    l_docno_m12 = json['l_docno_m12'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['ser'] = this.ser;
    data['docno'] = this.docno;
    data['refno'] = this.refno;
    data['dtype'] = this.dtype;
    data['daterec'] = this.daterec;
    data['shopno'] = this.shopno;
    data['pos'] = this.pos;
    data['custno'] = this.custno;
    data['type'] = this.type;
    data['amt'] = this.amt;
    data['total'] = this.total;
    data['total_mont1'] = this.total_mont1;
    data['total_mont2'] = this.total_mont2;
    data['total_mont3'] = this.total_mont3;
    data['total_mont4'] = this.total_mont4;
    data['total_mont5'] = this.total_mont5;
    data['total_mont6'] = this.total_mont6;
    data['total_mont7'] = this.total_mont7;
    data['total_mont8'] = this.total_mont8;
    data['total_mont9'] = this.total_mont9;
    data['total_mont10'] = this.total_mont10;
    data['total_mont11'] = this.total_mont11;
    data['total_mont12'] = this.total_mont12;

    data['l_date_m1'] = this.l_date_m1;
    data['l_date_m2'] = this.l_date_m2;
    data['l_date_m3'] = this.l_date_m3;
    data['l_date_m4'] = this.l_date_m4;
    data['l_date_m5'] = this.l_date_m5;
    data['l_date_m6'] = this.l_date_m6;
    data['l_date_m7'] = this.l_date_m7;
    data['l_date_m8'] = this.l_date_m8;
    data['l_date_m9'] = this.l_date_m9;
    data['l_date_m10'] = this.l_date_m10;
    data['l_date_m11'] = this.l_date_m11;
    data['l_date_m12'] = this.l_date_m12;

    data['l_docno_m1'] = this.l_docno_m1;
    data['l_docno_m2'] = this.l_docno_m2;
    data['l_docno_m3'] = this.l_docno_m3;
    data['l_docno_m4'] = this.l_docno_m4;
    data['l_docno_m5'] = this.l_docno_m5;
    data['l_docno_m6'] = this.l_docno_m6;
    data['l_docno_m7'] = this.l_docno_m7;
    data['l_docno_m8'] = this.l_docno_m8;
    data['l_docno_m9'] = this.l_docno_m9;
    data['l_docno_m10'] = this.l_docno_m10;
    data['l_docno_m11'] = this.l_docno_m11;
    data['l_docno_m12'] = this.l_docno_m12;
    return data;
  }
}
