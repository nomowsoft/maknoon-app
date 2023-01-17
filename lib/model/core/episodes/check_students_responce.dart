import 'package:maknoon/model/core/episodes/student_of_episode.dart';

class CheckStudentsResponce{
  List<int> deletedLinks;
  List<StudentOfEpisode> newLinks;
  bool update ;
  CheckStudentsResponce(
      {required this.deletedLinks,
      required this.newLinks,
      required this.update,});

  CheckStudentsResponce.fromJson(Map<String, dynamic> json,int episodeId)
      : deletedLinks = List<int>.from((json['deleted_links'] ?? []) as List),
        newLinks = ((json['new_links'] ?? []) as List ).map((e) =>  StudentOfEpisode.fromJson(e,episodeId)).toList(),
        update = json['update'] ?? false;

  Map<String, dynamic> toJson() => {
        "deletedEpisodes": deletedLinks,
        "new_episodes": newLinks,
        "update": update,
      };
}
