class BanktypeModel {
  String? ser;
  String? btype;
  String? st;
  String? data_update;

  BanktypeModel({this.ser, this.btype, this.st, this.data_update});

  BanktypeModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    btype = json['btype'];
    st = json['st'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['btype'] = this.btype;
    data['st'] = this.st;
    data['data_update'] = this.data_update;
    return data;
  }
}
