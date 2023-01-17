class StudentGeneralBehavior{
   int studentId;
  String generalBehavior;

  StudentGeneralBehavior({
    required this.studentId,
    required this.generalBehavior, 
  });

  StudentGeneralBehavior.fromJson(Map<String, dynamic> json)
      : studentId = json['studentId'] ?? 0,
        generalBehavior = json['generalBehavior'] ?? '';

  Map<String, dynamic> toJsonLocal() => {
        "studentId": studentId,
        "generalBehavior": generalBehavior
      };

   
}