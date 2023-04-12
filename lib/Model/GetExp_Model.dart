class ExpModel {
  String? ser;
  String? user;
  String? etype;
  String? exptser;
  String? expname;
  String? st;
  String? unit;
  String? unitser;
  String? sday;
  String? vat;
  String? wht;
  String? cal;
  String? pri;
  String? rser;
  String? fine;
  String? fine_unit;
  String? fine_late;
  String? fine_cal;
  String? fine_pri;
  String? auto;
  String? cal_auto;
  String? pri_auto;
  String? data_update;

  ExpModel(
      {this.ser,
      this.user,
      this.etype,
      this.exptser,
      this.expname,
      this.st,
      this.unit,
      this.unitser,
      this.sday,
      this.vat,
      this.wht,
      this.cal,
      this.pri,
      this.rser,
      this.fine,
      this.fine_unit,
      this.fine_late,
      this.fine_cal,
      this.fine_pri,
      this.auto,
      this.cal_auto,
      this.pri_auto,
      this.data_update});

  ExpModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    user = json['user'];
    etype = json['etype'];
    exptser = json['exptser'];
    expname = json['expname'];
    st = json['st'];
    unitser = json['unitser'];
    unit = json['unit'];
    sday = json['sday'];
    vat = json['vat'];
    wht = json['wht'];
    cal = json['cal'];
    pri = json['pri'];
    rser = json['rser'];
    fine = json['fine'];
    fine_unit = json['fine_unit'];
    fine_late = json['fine_late'];
    fine_cal = json['fine_cal'];
    fine_pri = json['fine_pri'];
    auto = json['auto'];
    cal_auto = json['cal_auto'];
    pri_auto = json['pri_auto'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['user'] = this.user;
    data['etype'] = this.etype;
    data['exptser'] = this.exptser;
    data['expname'] = this.expname;
    data['st'] = this.st;
    data['unitser'] = this.unitser;
    data['unit'] = this.unit;
    data['sdate'] = this.sday;
    data['vat'] = this.vat;
    data['wht'] = this.wht;
    data['cal'] = this.cal;
    data['pri'] = this.pri;
    data['rser'] = this.rser;
    data['fine'] = this.fine;
    data['fine_unit'] = this.fine_unit;
    data['fine_late'] = this.fine_late;
    data['fine_cal'] = this.fine_cal;
    data['fine_pri'] = this.fine_pri;
    data['auto'] = this.auto;
    data['cal_auto'] = this.cal_auto;
    data['pri_auto'] = this.pri_auto;
    data['data_update'] = this.data_update;
    return data;
  }
}
