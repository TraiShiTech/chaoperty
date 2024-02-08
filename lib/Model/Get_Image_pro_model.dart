class ImageProModel {
  String? ser;
  String? rser;
  String? imgName;
  String? textPro;
  String? type;
  String? url;
  String? st;
  String? dateTinme;

  ImageProModel(
      {this.ser,
      this.rser,
      this.imgName,
      this.textPro,
      this.type,
      this.url,
      this.st,
      this.dateTinme});

  ImageProModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    rser = json['rser'];
    imgName = json['img_name'];
    textPro = json['text_pro'];
    type = json['type'];
    url = json['url'];
    st = json['st'];
    dateTinme = json['date_tinme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['rser'] = this.rser;
    data['img_name'] = this.imgName;
    data['text_pro'] = this.textPro;
    data['type'] = this.type;
    data['url'] = this.url;
    data['st'] = this.st;
    data['date_tinme'] = this.dateTinme;
    return data;
  }
}
