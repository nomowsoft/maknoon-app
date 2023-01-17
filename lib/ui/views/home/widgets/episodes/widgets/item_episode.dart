import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maknoon/model/core/episodes/episode.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maknoon/ui/views/home/widgets/episodes/widgets/edisode_details/episode_details.dart';

class ItemEpisode extends StatefulWidget {
  final Episode episode;
  const ItemEpisode({Key? key, required this.episode}) : super(key: key);

  @override
  State<ItemEpisode> createState() => _ItemEpisodeState();
}

class _ItemEpisodeState extends State<ItemEpisode> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => EpisodeDetails(episode: widget.episode),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
            transition: Transition.fadeIn);
      },
      child: Container(
        color: const Color(0xffFCFCFC),
        child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(width: 2, color: Colors.white)),
            margin:
                EdgeInsets.only(left: 20.w, right: 20.w, top: 8.h, bottom: 8.h),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'images/quran.svg',
                        height: 50.h,
                        color: Get.theme.primaryColor,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Expanded(
                        child: Text(
                          widget.episode.displayName,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w800,
                              color: Get.theme.secondaryHeaderColor,
                              height: 1.5),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: SizeConfig.textScaleFactor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'episode_type'.tr ,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                              color: Colors.black54,
                            ),
                            textScaleFactor: SizeConfig.textScaleFactor,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            widget.episode.epsdType,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                              color: Colors.black,
                            ),
                            textScaleFactor: SizeConfig.textScaleFactor,
                          ),
                        ],
                      )),
                      Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'episode_works'.tr ,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                              color: Colors.black54,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textScaleFactor: SizeConfig.textScaleFactor,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            widget.episode.epsdWork,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                              color: Colors.black,
                            ),
                            textScaleFactor: SizeConfig.textScaleFactor,
                          ),
                        ],
                      ))
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
