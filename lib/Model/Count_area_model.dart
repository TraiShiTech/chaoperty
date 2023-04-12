class AreaCountModel {
  String? counta;

  AreaCountModel(
      {this.counta});

  AreaCountModel.fromJson(Map<String, dynamic> json) {
    counta = json['counta'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counta'] = this.counta;
    
    return data;
  }
}
