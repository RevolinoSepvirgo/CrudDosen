class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String jabatan;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.jabatan,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      jabatan: json['jabatan'],
      

    );
  }
}
