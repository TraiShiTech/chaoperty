class MaintenanceModel {
  String? ser;
  String? datex;
  String? timex;
  String? user;
  String? rser;
  String? zser;
  String? aser;
  String? lncode;
  String? ln;
  String? custno;
  String? sname;
  String? mdate;
  String? mdescr;
  String? mst;
  String? rdate;
  String? rdescr;
  String? st;
  String? zn;
  String? dateUpdate;

  MaintenanceModel(
      {this.ser,
      this.datex,
      this.timex,
      this.user,
      this.rser,
      this.zser,
      this.aser,
      this.lncode,
      this.ln,
      this.custno,
      this.sname,
      this.mdate,
      this.mdescr,
      this.mst,
      this.rdate,
      this.st,
      this.zn,
      this.dateUpdate});

  MaintenanceModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    user = json['user'];
    rser = json['rser'];
    zser = json['zser'];
    aser = json['aser'];
    lncode = json['lncode'];
    ln = json['ln'];
    custno = json['custno'];
    sname = json['sname'];
    mdate = json['mdate'];
    mdescr = json['mdescr'];
    mst = json['mst'];
    rdate = json['rdate'];
    rdescr = json['rdescr'];
    st = json['st'];
    zn = json['zn'];
    dateUpdate = json['date_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['user'] = this.user;
    data['rser'] = this.rser;
    data['zser'] = this.zser;
    data['aser'] = this.aser;
    data['lncode'] = this.lncode;
    data['ln'] = this.ln;
    data['custno'] = this.custno;
    data['sname'] = this.sname;
    data['mdate'] = this.mdate;
    data['mdescr'] = this.mdescr;
    data['mst'] = this.mst;
    data['rdate'] = this.rdate;
    data['rdescr'] = this.rdescr;
    data['st'] = this.st;
    data['zn'] = this.zn;
    data['date_update'] = this.dateUpdate;
    return data;
  }
}
