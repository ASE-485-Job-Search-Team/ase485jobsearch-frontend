class CreateCompanyRequestModel {
  CreateCompanyRequestModel({
    required this.companyId,
    required this.companyName,
  });

  late final String companyId;
  late final String companyName;

  CreateCompanyRequestModel.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    companyName = json['companyName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['companyId'] = companyId;
    _data['companyName'] = companyName;
    return _data;
  }
}
