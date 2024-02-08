class PayMentModel {
  String? ser;
  String? datex;
  String? timex;
  String? ptser;
  String? ptname;
  String? bser;
  String? bank;
  String? bno;
  String? bname;
  String? bsaka;
  String? btser;
  String? btype;
  String? st;
  String? rser;
  String? accode;
  String? co;
  String? dataUpdate;
  String? auto;
  String? ser_payweb;
  String? img;
  String? fine;
  String? fine_c;
  String? fine_a;
  String?  ser_han;

  PayMentModel({
    this.ser,
    this.datex,
    this.timex,
    this.ptser,
    this.ptname,
    this.bser,
    this.bank,
    this.bno,
    this.bname,
    this.bsaka,
    this.btser,
    this.btype,
    this.st,
    this.rser,
    this.accode,
    this.co,
    this.dataUpdate,
    this.ser_payweb,
    this.auto,
    this.img,
    this.fine,
    this.fine_c,
    this.fine_a,this.ser_han
  });

  PayMentModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    ptser = json['ptser'];
    ptname = json['ptname'];
    bser = json['bser'];
    bank = json['bank'];
    bno = json['bno'];
    bname = json['bname'];
    bsaka = json['bsaka'];
    btser = json['btser'];
    btype = json['btype'];
    st = json['st'];
    rser = json['rser'];
    accode = json['accode'];
    co = json['co'];
    dataUpdate = json['data_update'];
    auto = json['auto'];
    ser_payweb = json['ser_payweb'];
    img = json['img'];
    fine = json['fine'];
    fine_c = json['fine_c'];
    fine_a = json['fine_a'];
    ser_han= json['ser_han'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['ptser'] = this.ptser;
    data['ptname'] = this.ptname;
    data['bser'] = this.bser;
    data['bank'] = this.bank;
    data['bno'] = this.bno;
    data['bname'] = this.bname;
    data['bsaka'] = this.bsaka;
    data['btser'] = this.btser;
    data['btype'] = this.btype;
    data['st'] = this.st;
    data['rser'] = this.rser;
    data['accode'] = this.accode;
    data['co'] = this.co;
    data['data_update'] = this.dataUpdate;
    data['auto'] = this.auto;
    data['ser_payweb'] = this.ser_payweb;
    data['img'] = this.img;
    data['fine'] = this.fine;
    data['fine_c'] = this.fine_c;
    data['fine_a'] = this.fine_a;
    data['ser_han'] = this.ser_han;

    return data;
  }
}
