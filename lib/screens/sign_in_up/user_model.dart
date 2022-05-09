class user2 {
  final String name;
  final int id;
  final int phone;

  user2({required this.name, required this.id, required this.phone});

  factory user2.fromJson(Map<String, dynamic> json) {
    return user2(
      name: json['username'],
      phone: json['phone'],
      id: json['id'],
    );
  }
}
