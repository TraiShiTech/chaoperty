class ChatModel {
  String? ser;
  String? datex;
  String? timex;
  String? user;
  String? rser;
  String? content;
  String? img;
  String? audio;
  String? data_update;

  ChatModel(
      {this.ser,
      this.datex,
      this.timex,
      this.user,
      this.rser,
      this.content,
      this.img,
      this.audio,
      this.data_update});

  ChatModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    user = json['user'];
    rser = json['rser'];
    content = json['content'];
    img = json['img'];
    audio = json['audio'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['user'] = this.user;
    data['rser'] = this.rser;
    data['content'] = this.content;
    data['img'] = this.img;
    data['audio'] = this.audio;
    data['data_update'] = this.data_update;
    return data;
  }
}
