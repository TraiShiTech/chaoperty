class VatSModel {
  String? ser;
  String? name;

  VatSModel({this.ser, this.name});

  VatSModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['name'] = this.name;
    return data;
  }
}
