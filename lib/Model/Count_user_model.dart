class UserCountModel {
  String? countu;

  UserCountModel({this.countu});

  UserCountModel.fromJson(Map<String, dynamic> json) {
    countu = json['countu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countu'] = this.countu;

    return data;
  }
}
