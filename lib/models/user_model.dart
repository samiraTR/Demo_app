class User {
  String id;
  String name;
  String gender;
  bool favorite;
  bool blocked;

  User({
    required this.id,
    required this.name,
    required this.gender,
    required this.favorite,
    required this.blocked,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        name: json["name"],
        gender: json["gender"],
        favorite: json["favorite"],
        blocked: json["blocked"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "gender": gender,
      "favorite": favorite,
      "blocked": blocked
    };
  }
}
