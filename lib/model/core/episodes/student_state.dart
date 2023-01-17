
class StudentState {
  int studentId, planId;
  String state, date;

  StudentState({
    required this.studentId,
    required this.planId,
    required this.state,
    required this.date,
  });

  StudentState.fromJson(Map<String, dynamic> json)
      : studentId = json['studentId'] ?? 0,
        planId = json['planId'] ?? 0,
        date = json['date'] ?? '',
        state = json['state'] ?? '';

  Map<String, dynamic> toJsonLocal() => {
        "studentId": studentId,
        "planId": planId,
        "date": date,
        "state": state
      };

  Map<String, dynamic> toJson() => {
        "plan_id": planId,
        "date": date,
        "state": state
      };
}
