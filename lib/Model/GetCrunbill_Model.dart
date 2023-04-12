class CrunbillModel {
  String? ser;
  String? datex;
  String? timex;
  String? doctype;
  String? yearx;
  String? monthx;
  String? billno;
  String? dataUpdate;

  CrunbillModel(
      {this.ser,
      this.datex,
      this.timex,
      this.doctype,
      this.yearx,
      this.monthx,
      this.billno,
      this.dataUpdate});

  CrunbillModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    doctype = json['doctype'];
    yearx = json['yearx'];
    monthx = json['monthx'];
    billno = json['billno'];
    dataUpdate = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['doctype'] = this.doctype;
    data['yearx'] = this.yearx;
    data['monthx'] = this.monthx;
    data['billno'] = this.billno;
    data['data_update'] = this.dataUpdate;
    return data;
  }
}
