import 'package:maknoon/model/core/episodes/episode.dart';
import 'package:maknoon/model/core/episodes/student_of_episode.dart';

class EpisodeStudent extends Episode {
  late List<StudentOfEpisode> students;
  EpisodeStudent(
      {required super.displayName,
      required super.name,
      required super.id,
      required super.epsdType,
      required super.epsdWork});

  EpisodeStudent.fromJson(Map<String, dynamic> json)
      : students = (json['students'] as List)
            .map((e) => StudentOfEpisode.fromJson(e, json['id'] ?? 0))
            .toList(),
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "display_name": displayName,
        "epsd_type": epsdType,
        "epsd_work": epsdWork,
        "name": name,
      };
}
