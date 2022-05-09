class user {
  final String name;
  final int id;
  final int phone;
  final String email;

  user({
    required this.name,
    required this.id,
    required this.phone,
    required this.email,
  });

  factory user.fromJson(Map<String, dynamic> json) {
    return user(
      name: json['name'],
      phone: json['phone'],
      id: json['id'],
      email: json['email'],
    );
  }
}
