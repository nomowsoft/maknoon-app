class ContentTypeHeaders {
  static String formUrlEncoded = 'application/x-www-form-urlencoded',
      multipartFormData = 'multipart/form-data',
      applicationJson = 'application/json';
}
 
class PlanLinesType {
  static String listen = 'listen', reviewbig = 'reviewbig', reviewsmall = 'reviewsmall' , tlawa ='tlawa';
}

class StudentStateType {
  static String present = 'present', absent = 'absent', absentExcuse = 'absent_excuse' , notRead ='not_read', excuse ='excuse' ,delay ='delay';
} 
class GeneralBehaviorType {
  static String excellent = 'excellent', veryGood = 'very_good', good = 'good' , notRead ='not_read', accepted ='accepted' ,weak ='weak';
} 

class OperationType {
  static int create = 1, update = 2, delete = 3;
}
