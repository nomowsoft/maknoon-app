class NotificationModel {
  String name,dateNotification,description,state;
  int id;

  NotificationModel({required this.dateNotification,required this.id,required this.name,required this.description,required this.state});

  NotificationModel.fromJson(Map<String, dynamic> json):
    dateNotification = json['dateNotification'] ?? '',
    description = json['description'] ?? '',
    state = json['state'] ?? '',
    id = json['id'] ?? 0,
    name = json['name'] ?? '';

  Map<String, dynamic> toMap() => {
        "id": id,
        "display_name": dateNotification,
        "description": description,
        "state": state,
        "name": name
      };
}
