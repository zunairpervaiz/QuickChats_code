import 'dart:convert';

User userFromJson(String str) => User.fromJson(jsonDecode(str));

class User {
  User({this.name, this.age, this.married, this.kids, this.hobbies});

  String? name;
  int? age;
  bool? married;
  dynamic kids;
  List<dynamic>? hobbies;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json['name'],
        age: json['age'],
        married: json['married'],
        kids: json['kids'],
        hobbies: json['hobbies'],
      );
}
