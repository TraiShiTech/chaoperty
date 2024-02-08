class ElectricityModel {
  String? ser;
  String? nameEle;
  String? eleOne;
  String? eleMitOne;
  String? eleTwo;
  String? eleMitTwo;
  String? eleThree;
  String? eleMitThree;
  String? eleTour;
  String? eleMitTour;
  String? eleFive;
  String? eleMitFive;
  String? eleSix;
  String? eleMitSix;
  String? eleTf;
  String? vat;
  String? wht;
  String? other;
  String? st;
  String? eleGobOne;
  String? eleGobTwo;
  String? eleGobThree;
  String? eleGobTour;
  String? eleGobFive;
  String? eleGobSix;

  ElectricityModel(
      {this.ser,
      this.nameEle,
      this.eleOne,
      this.eleMitOne,
      this.eleTwo,
      this.eleMitTwo,
      this.eleThree,
      this.eleMitThree,
      this.eleTour,
      this.eleMitTour,
      this.eleFive,
      this.eleMitFive,
      this.eleSix,
      this.eleMitSix,
      this.eleTf,
      this.vat,
      this.wht,
      this.other,
      this.st,
      this.eleGobOne,
      this.eleGobTwo,
      this.eleGobThree,
      this.eleGobTour,
      this.eleGobFive,
      this.eleGobSix});

  ElectricityModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    nameEle = json['name_ele'];
    eleOne = json['ele_one'];
    eleMitOne = json['ele_mit_one'];
    eleTwo = json['ele_two'];
    eleMitTwo = json['ele_mit_two'];
    eleThree = json['ele_three'];
    eleMitThree = json['ele_mit_three'];
    eleTour = json['ele_tour'];
    eleMitTour = json['ele_mit_tour'];
    eleFive = json['ele_five'];
    eleMitFive = json['ele_mit_five'];
    eleSix = json['ele_six'];
    eleMitSix = json['ele_mit_six'];
    eleTf = json['ele_tf'];
    vat = json['vat'];
    wht = json['wht'];
    other = json['other'];
    st = json['st'];
    eleGobOne = json['ele_gob_one'];
    eleGobTwo = json['ele_gob_two'];
    eleGobThree = json['ele_gob_three'];
    eleGobTour = json['ele_gob_tour'];
    eleGobFive = json['ele_gob_five'];
    eleGobSix = json['ele_gob_six'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['name_ele'] = this.nameEle;
    data['ele_one'] = this.eleOne;
    data['ele_mit_one'] = this.eleMitOne;
    data['ele_two'] = this.eleTwo;
    data['ele_mit_two'] = this.eleMitTwo;
    data['ele_three'] = this.eleThree;
    data['ele_mit_three'] = this.eleMitThree;
    data['ele_tour'] = this.eleTour;
    data['ele_mit_tour'] = this.eleMitTour;
    data['ele_five'] = this.eleFive;
    data['ele_mit_five'] = this.eleMitFive;
    data['ele_six'] = this.eleSix;
    data['ele_mit_six'] = this.eleMitSix;
    data['ele_tf'] = this.eleTf;
    data['vat'] = this.vat;
    data['wht'] = this.wht;
    data['other'] = this.other;
    data['st'] = this.st;
    data['ele_gob_one'] = this.eleGobOne;
    data['ele_gob_two'] = this.eleGobTwo;
    data['ele_gob_three'] = this.eleGobThree;
    data['ele_gob_tour'] = this.eleGobTour;
    data['ele_gob_five'] = this.eleGobFive;
    data['ele_gob_six'] = this.eleGobSix;
    return data;
  }
}
