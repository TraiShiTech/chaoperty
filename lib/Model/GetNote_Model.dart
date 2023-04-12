class NoteModel {
  String? ser;
  String? datex;
  String? timex;
  String? user;
  String? rser;
  String? descr;
  String? st;
  String? dataUpdate;

  NoteModel(
      {this.ser,
      this.datex,
      this.timex,
      this.user,
      this.rser,
      this.descr,
      this.st,
      this.dataUpdate});

  NoteModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    user = json['user'];
    rser = json['rser'];
    descr = json['descr'];
    st = json['st'];
    dataUpdate = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['user'] = this.user;
    data['rser'] = this.rser;
    data['descr'] = this.descr;
    data['st'] = this.st;
    data['data_update'] = this.dataUpdate;
    return data;
  }
}
