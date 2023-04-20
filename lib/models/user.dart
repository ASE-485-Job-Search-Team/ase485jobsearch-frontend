class User {
  final String id;
  final String name;
  final String email;
  final String? resume;
  final bool isAdmin;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.resume,
    required this.isAdmin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      resume: json['resume'],
      isAdmin: json['isAdmin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'resume': resume,
      'isAdmin': isAdmin,
    };
  }
}
