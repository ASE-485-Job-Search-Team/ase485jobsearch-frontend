class RegisterRequestCompanyModel {
  RegisterRequestCompanyModel({
    required this.company,
    required this.email,
    required this.password,
    required this.isAdmin,
  });

  late final String company;
  late final String email;
  late final String password;
  late final bool isAdmin;

  RegisterRequestCompanyModel.fromJson(Map<String, dynamic> json) {
    company = json['company'];
    email = json['email'];
    password = json['password'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['company'] = company;
    _data['email'] = email;
    _data['password'] = password;
    _data['isAdmin'] = isAdmin;
    return _data;
  }
}
