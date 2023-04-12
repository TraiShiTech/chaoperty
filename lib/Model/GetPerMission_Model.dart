class PerMissionModel {
  String? ser;
  String? perm;
  String? name_icon;
  String? icon;
  String? st;
  String? data_update;

  PerMissionModel(
      {this.ser,
      this.perm,
      this.name_icon,
      this.icon,
      this.st,
      this.data_update});

  PerMissionModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    perm = json['perm'];
    name_icon = json['name_icon'];
    icon = json['icon'];
    st = json['st'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['perm'] = this.perm;
    data['name_icon'] = this.name_icon;
    data['icon'] = this.icon;
    data['st'] = this.st;
    data['data_update'] = this.data_update;
    return data;
  }
}
