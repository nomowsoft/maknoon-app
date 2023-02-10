 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maknoon/controller/home_controller.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';
import 'package:maknoon/ui/shared/widgets/color_loader/color_loader.dart';
import 'package:maknoon/ui/views/home/widgets/episodes/widgets/item_episode.dart';

class Episodes extends StatefulWidget {
  const Episodes({super.key});

  @override
  State<Episodes> createState() => _EpisodesState();
}

class _EpisodesState extends State<Episodes> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (HomeController homeController) => Scaffold(body:
          SafeArea(child: OrientationBuilder(builder: (context, orientation) {
        SizeConfig('initialSize').init(originalWidth: 428, originalHeight: 926);
        return Stack(children: [
          Positioned.fill(
            child: Image.asset(
              'images/bgR2.png',
              repeat: ImageRepeat.repeat,
            ),
          ),
          Positioned.fill(
            child: homeController.gettingEpisodes
                          ? const Center(
                              child: ColorLoader(),
                            )
                          : homeController.hasError
                              ? Center(
                                  child: InkWell(
                                  onTap: () {
                                    homeController.loadEpisodes();
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Icon(Icons.refresh,
                                          color: Colors.red.shade700),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(
                                        homeController.responseEpisodes
                                                .isErrorConnection
                                            ? 'error_connect_to_netwotk'.tr
                                            : 'error_connect_to_server'.tr,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textScaleFactor:
                                            SizeConfig.textScaleFactor,
                                      ),
                                    ],
                                  ),
                                ))
                              : ListView.separated(
                                  itemBuilder: (_, index) => ItemEpisode(
                                      episode:
                                          homeController.listEpisodes[index]),
                                  separatorBuilder: (_, __) => const SizedBox(),
                                  itemCount: homeController.listEpisodes.length)
                      ,
          )]);}))));
  }
}