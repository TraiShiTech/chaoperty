class OtpModel {
  String? ser;
  String? ser_id;
  String? tem_id;
  String? user_id;
  String? use_id;
  String? remark;

  OtpModel({
    this.ser,
    this.ser_id,
    this.tem_id,
    this.user_id,
    this.use_id,
    this.remark,
  });

  OtpModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    ser_id = json['ser_id'];
    tem_id = json['tem_id'];
    user_id = json['user_id'];
    use_id = json['use_id'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['ser_id'] = this.ser_id;
    data['tem_id'] = this.tem_id;
    data['user_id'] = this.user_id;
    data['use_id'] = this.use_id;
    data['remark'] = this.remark;
    return data;
  }
}
