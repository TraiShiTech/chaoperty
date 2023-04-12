class ObjTestModel {
  String? ser;
  String? name;
  String? lname;

  ObjTestModel({this.ser, this.name, this.lname});

  ObjTestModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    name = json['name'];
    lname = json['lname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['name'] = this.name;
    data['lname'] = this.lname;
    return data;
  }
}
