class Grocery {
  int? id;
  String? name;

  Grocery({
    this.id,
    this.name,
  });

  factory Grocery.fromMap(Map<String, dynamic> json) {
    return Grocery(id: json["id"], name: json["name"]);
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name};
  }
}
