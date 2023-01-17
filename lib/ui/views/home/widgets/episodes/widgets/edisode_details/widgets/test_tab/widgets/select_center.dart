import 'package:flutter/material.dart';
import 'package:maknoon/controller/home_controller.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';
import 'package:get/get.dart';
import 'package:maknoon/model/core/test/center.dart' as center;

class SelectCenter extends StatefulWidget {
  const SelectCenter({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectCenter> createState() => _SelectCenterState();
}

class _SelectCenterState extends State<SelectCenter> {
  late List<center.Center> listCenters;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    HomeController homeController = Get.find<HomeController>();
    listCenters = homeController.listCenters ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...listCenters.map((e) => InkWell(
                onTap: (() {
                  Get.back(result: e);
                }),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              e.name ,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                height: 1.4
                              ),
                              textAlign: TextAlign.center,
                              textScaleFactor: SizeConfig.textScaleFactor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      height: 10.h,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
