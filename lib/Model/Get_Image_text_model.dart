class ImageTextModel {
  String? image;
  String? url;

  ImageTextModel({
    this.image,
    this.url,
  });

  ImageTextModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['url'] = this.url;
    return data;
  }
}
