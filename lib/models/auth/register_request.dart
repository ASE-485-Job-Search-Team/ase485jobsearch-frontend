class RegisterRequestModel {
  RegisterRequestModel({
    required this.first,
    required this.last,
    required this.email,
    required this.password,
    required this.isAdmin,
  });

  late final String first;
  late final String last;
  late final String email;
  late final String password;
  late final bool isAdmin;

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    email = json['email'];
    password = json['password'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first'] = first;
    _data['last'] = last;
    _data['email'] = email;
    _data['password'] = password;
    _data['isAdmin'] = isAdmin;
    return _data;
  }
}
