class TypeXModel {
  String? ser;
  String? typex;
  String? st;
  String? data_update;

  TypeXModel({this.ser, this.typex, this.st, this.data_update});

  TypeXModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    typex = json['typex'];
    st = json['st'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['typex'] = this.typex;
    data['st'] = this.st;
    data['data_update'] = this.data_update;
    return data;
  }
}
