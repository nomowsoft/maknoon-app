class Center{
  int id;
  String name;

  Center({required this.id,required this.name});

  Center.fromJson(Map<String, dynamic> json):
    id = json['id'] ?? 0,
    name = json['name'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] =  id;
    data['name'] = name;
    return data;
  }

  factory Center.fromMap(Map<String, dynamic> json) => Center(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}