import 'package:flutter/material.dart';
import 'package:maknoon/controller/home_controller.dart';
import 'package:maknoon/model/core/center_test/center_prepar_type.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';
import 'package:get/get.dart'; 

class SelectCenterPreparType extends StatefulWidget {
  const SelectCenterPreparType({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectCenterPreparType> createState() => _SelectCenterPreparTypeState();
}

class _SelectCenterPreparTypeState extends State<SelectCenterPreparType> {
  late List<CenterPreparType> listCenterPreparType;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    HomeController homeController = Get.find<HomeController>();
    listCenterPreparType = homeController.listCenterPreparTypes??[];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...listCenterPreparType.map((e) => InkWell(
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
                              e.parentName ,
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
