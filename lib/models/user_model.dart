class UserModel {
  String iD;
  String chooseType;
  String name;
  String user;
  String password;

  UserModel({this.iD, this.chooseType, this.name, this.user, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    chooseType = json['ChooseType'];
    name = json['Name'];
    user = json['User'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ChooseType'] = this.chooseType;
    data['Name'] = this.name;
    data['User'] = this.user;
    data['Password'] = this.password;
    return data;
  }
}
