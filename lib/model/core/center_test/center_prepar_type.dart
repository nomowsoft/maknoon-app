class CenterPreparType{
  int parentId;
  String parentName;

  CenterPreparType({required this.parentId,required this.parentName});

  CenterPreparType.fromJson(Map<String, dynamic> json):
    parentId = json['parent_id'] ?? 0,
    parentName = json['parent_name'] ?? '';

  Map<String, dynamic> toMap() => {
        "parent_id": parentId,
        "parent_name": parentName,
      };
}