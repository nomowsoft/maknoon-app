class Behaviour {
  int id;
  String name;

  Behaviour({required this.id,required this.name});

  Behaviour.fromJson(Map<String, dynamic> json):
    id = json['id'] ?? 0,
    name = json['name'] ?? '';
 
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };     
}

class BehaviourStudent {
  int linkId;
  String name;

  BehaviourStudent({required this.linkId,required this.name});

  BehaviourStudent.fromJson(Map<String, dynamic> json):
    linkId = json['linkId'] ?? 0,
    name = json['name'] ?? '';
 
  Map<String, dynamic> toJson() => {
        "linkId": linkId,
        "name": name,
      };     
}

class NewBehaviour {
  int planId,behaviorId;
  bool sendToParent,sendToTeacher;

  NewBehaviour({required this.planId,required this.behaviorId,required this.sendToParent,required this.sendToTeacher});

  NewBehaviour.fromJson(Map<String, dynamic> json):
    planId = json['planId'] ?? 0,
    behaviorId = json['behaviorId'] ?? 0,
    sendToParent = json['sendToParent'] == 0 ? false : true ,
    sendToTeacher = json['sendToTeacher'] == 0 ? false : true ;
 
  Map<String, dynamic> toJson() => {
        "planId": planId,
        "behaviorId": behaviorId,
        "sendToParent": sendToParent?1:0,
        "sendToTeacher": sendToTeacher?1:0,
      };     
}

