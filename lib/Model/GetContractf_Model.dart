class ContractfModel {
  String? ser;
  String? datex;
  String? timex;
  String? cid;
  String? cxname;
  String? filename;
  String? st;
  String? data_update;

  ContractfModel(
      {this.ser,
      this.datex,
      this.timex,
      this.cid,
      this.cxname,
      this.filename,
      this.st,
      this.data_update});

  ContractfModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    cid = json['cid'];
    cxname = json['cxname'];
    filename = json['filename'];
    st = json['st'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['cid'] = this.cid;
    data['cxname'] = this.cxname;
    data['filename'] = this.filename;
    data['st'] = this.st;
    data['data_update'] = this.data_update;
    return data;
  }
}
