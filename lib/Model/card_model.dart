class CerdModel {
  String? amphur;
  String? birthDate;
  String? cardType;
  String? citizenNo;
  String? expiryDate;
  String? firstNameEn;
  String? firstNameTh;
  String? gender;
  String? homeNo;
  String? issueDate;
  String? issueNo;
  String? issuePlace;
  String? issuerNo;
  String? lastNameEn;
  String? lastNameTh;
  String? middleNameEn;
  String? middleNameTh;
  String? moo;
  String? photo;
  String? province;
  String? road;
  String? soi;
  String? titleAmphur;
  String? titleMoo;
  String? titleNameEn;
  String? titleNameTh;
  String? titleProvince;
  String? titleRoad;
  String? titleSoi;
  String? titleTumbol;
  String? trok;
  String? tumbol;
  String? unknownNo;

  CerdModel(
      {this.amphur,
      this.birthDate,
      this.cardType,
      this.citizenNo,
      this.expiryDate,
      this.firstNameEn,
      this.firstNameTh,
      this.gender,
      this.homeNo,
      this.issueDate,
      this.issueNo,
      this.issuePlace,
      this.issuerNo,
      this.lastNameEn,
      this.lastNameTh,
      this.middleNameEn,
      this.middleNameTh,
      this.moo,
      this.photo,
      this.province,
      this.road,
      this.soi,
      this.titleAmphur,
      this.titleMoo,
      this.titleNameEn,
      this.titleNameTh,
      this.titleProvince,
      this.titleRoad,
      this.titleSoi,
      this.titleTumbol,
      this.trok,
      this.tumbol,
      this.unknownNo});

  CerdModel.fromJson(Map<String, dynamic> json) {
    amphur = json['Amphur'];
    birthDate = json['BirthDate'];
    cardType = json['CardType'];
    citizenNo = json['CitizenNo'];
    expiryDate = json['ExpiryDate'];
    firstNameEn = json['FirstNameEn'];
    firstNameTh = json['FirstNameTh'];
    gender = json['Gender'];
    homeNo = json['HomeNo'];
    issueDate = json['IssueDate'];
    issueNo = json['IssueNo'];
    issuePlace = json['IssuePlace'];
    issuerNo = json['IssuerNo'];
    lastNameEn = json['LastNameEn'];
    lastNameTh = json['LastNameTh'];
    middleNameEn = json['MiddleNameEn'];
    middleNameTh = json['MiddleNameTh'];
    moo = json['Moo'];
    photo = json['Photo'];
    province = json['Province'];
    road = json['Road'];
    soi = json['Soi'];
    titleAmphur = json['TitleAmphur'];
    titleMoo = json['TitleMoo'];
    titleNameEn = json['TitleNameEn'];
    titleNameTh = json['TitleNameTh'];
    titleProvince = json['TitleProvince'];
    titleRoad = json['TitleRoad'];
    titleSoi = json['TitleSoi'];
    titleTumbol = json['TitleTumbol'];
    trok = json['Trok'];
    tumbol = json['Tumbol'];
    unknownNo = json['UnknownNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Amphur'] = this.amphur;
    data['BirthDate'] = this.birthDate;
    data['CardType'] = this.cardType;
    data['CitizenNo'] = this.citizenNo;
    data['ExpiryDate'] = this.expiryDate;
    data['FirstNameEn'] = this.firstNameEn;
    data['FirstNameTh'] = this.firstNameTh;
    data['Gender'] = this.gender;
    data['HomeNo'] = this.homeNo;
    data['IssueDate'] = this.issueDate;
    data['IssueNo'] = this.issueNo;
    data['IssuePlace'] = this.issuePlace;
    data['IssuerNo'] = this.issuerNo;
    data['LastNameEn'] = this.lastNameEn;
    data['LastNameTh'] = this.lastNameTh;
    data['MiddleNameEn'] = this.middleNameEn;
    data['MiddleNameTh'] = this.middleNameTh;
    data['Moo'] = this.moo;
    data['Photo'] = this.photo;
    data['Province'] = this.province;
    data['Road'] = this.road;
    data['Soi'] = this.soi;
    data['TitleAmphur'] = this.titleAmphur;
    data['TitleMoo'] = this.titleMoo;
    data['TitleNameEn'] = this.titleNameEn;
    data['TitleNameTh'] = this.titleNameTh;
    data['TitleProvince'] = this.titleProvince;
    data['TitleRoad'] = this.titleRoad;
    data['TitleSoi'] = this.titleSoi;
    data['TitleTumbol'] = this.titleTumbol;
    data['Trok'] = this.trok;
    data['Tumbol'] = this.tumbol;
    data['UnknownNo'] = this.unknownNo;
    return data;
  }
}
