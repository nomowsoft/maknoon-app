class Period {
  int id;
  String name;

  Period({required this.id,required this.name});

  Period.fromJson(Map<String, dynamic> json):
    id = json['id'] ?? 0,
    name = json['name'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] =  id;
    data['name'] = name;
    return data;
  }

  factory Period.fromMap(Map<String, dynamic> json) => Period(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}