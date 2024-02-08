class KeyuserModel {
  String? ser;
  String? key;
  String? spack;
  String? use;
  String? email;
  String? seruser;
  KeyuserModel(
      {this.ser, this.key, this.spack, this.use, this.email, this.seruser});

  KeyuserModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    key = json['key'];
    spack = json['spack'];
    use = json['use'];
    email = json['email'];
    seruser = json['seruser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['key'] = this.key;
    data['spack'] = this.spack;
    data['use'] = this.use;
    data['email'] = this.email;
    data['seruser'] = this.seruser;
    return data;
  }
}
