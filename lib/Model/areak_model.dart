class AreakModel {
  String? ser;
  String? datex;
  String? timex;
  String? cser;
  String? zser;
  String? aser;
  String? aserQout;
  String? type;
  String? sdate;
  String? ldate;
  String? dataUpdate;

  AreakModel(
      {this.ser,
      this.datex,
      this.timex,
      this.cser,
      this.zser,
      this.aser,
      this.aserQout,
      this.type,
      this.sdate,
      this.ldate,
      this.dataUpdate});

  AreakModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    cser = json['cser'];
    zser = json['zser'];
    aser = json['aser'];
    aserQout = json['aser_qout'];
    type = json['type'];
    sdate = json['sdate'];
    ldate = json['ldate'];
    dataUpdate = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['cser'] = this.cser;
    data['zser'] = this.zser;
    data['aser'] = this.aser;
    data['aser_qout'] = this.aserQout;
    data['type'] = this.type;
    data['sdate'] = this.sdate;
    data['ldate'] = this.ldate;
    data['data_update'] = this.dataUpdate;
    return data;
  }
}
