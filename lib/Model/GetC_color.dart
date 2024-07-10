class Color_Model {
  String? ser;
  String? user;
  String? color_fool;
  String? color_bg;
  String? img;
  String? img2;
  String? img3;
  String? img4;
  String? img5;
  String? data_update;
  String? text;

  Color_Model({
    this.ser,
    this.user,
    this.color_fool,
    this.color_bg,
    this.img,
    this.img2,
    this.img3,
    this.img4,
    this.img5,
    this.data_update,
    this.text,
  });

  Color_Model.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    user = json['user'];
    color_fool = json['color_fool'];
    color_bg = json['color_bg'];
    img = json['img'];
    img2 = json['img2'];
    img3 = json['img3'];
    img4 = json['img4'];
    img5 = json['img5'];
    data_update = json['data_update'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['user'] = this.user;
    data['color_fool'] = this.color_fool;
    data['color_bg'] = this.color_bg;
    data['img'] = this.img;
    data['img2'] = this.img2;
    data['img3'] = this.img3;
    data['img4'] = this.img4;
    data['img5'] = this.img5;
    data['data_update'] = this.data_update;
    data['text'] = this.text;
    return data;
  }
}
