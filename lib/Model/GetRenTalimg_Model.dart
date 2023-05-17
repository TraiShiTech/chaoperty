class RenTalimgModel {
  String? ser;
  String? datex;
  String? timex;
  String? user;
  String? rser;
  String? img;
  String? type;
  String? data_Update;

  RenTalimgModel(
      {this.ser,
      this.datex,
      this.timex,
      this.user,
      this.rser,
      this.img,
      this.type,
      this.data_Update});

  RenTalimgModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    user = json['user'];
    rser = json['rser'];
    img = json['img'];
    type = json['type'];
    data_Update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['user'] = this.user;
    data['rser'] = this.rser;
    data['img'] = this.img;
    data['type'] = this.type;
    data['data_update'] = this.data_Update;
    return data;
  }
}
