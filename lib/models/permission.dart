class Permission {
  String? id;
  String? name;
  String? code;
  String? createdAt;
  String? updatedAt;

  Permission({this.id, this.name, this.code, this.updatedAt, this.createdAt});
  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
        id: json["id"]!,
        name: json["name"],
        code: json["code"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
