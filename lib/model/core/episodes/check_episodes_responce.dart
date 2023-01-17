import 'package:maknoon/model/core/episodes/episode_student.dart';

class CheckEpisodesResponce {
  List<int> deletedEpisodes;
  List<EpisodeStudent> newEpisodes;
  bool update ;
  CheckEpisodesResponce(
      {required this.deletedEpisodes,
      required this.newEpisodes,
      required this.update,});

  CheckEpisodesResponce.fromJson(Map<String, dynamic> json)
      : deletedEpisodes = List<int>.from((json['deleted_episodes'] ?? []) as List),
        newEpisodes = ((json['new_episodes'] ?? []) as List ).map((e) =>  EpisodeStudent.fromJson(e)).toList(),
        update = json['update'] ?? false;

  Map<String, dynamic> toJson() => {
        "deletedEpisodes": deletedEpisodes,
        "new_episodes": newEpisodes,
        "update": update,
      };
}
