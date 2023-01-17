import 'package:flutter/material.dart';
import 'package:maknoon/controller/home_controller.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';
import 'package:get/get.dart';
import 'package:maknoon/model/core/test/period.dart';

class SelectPeriod extends StatefulWidget {
  const SelectPeriod({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectPeriod> createState() => _SelectPeriodState();
}

class _SelectPeriodState extends State<SelectPeriod> {
  late List<Period> listPeriods;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    HomeController homeController = Get.find<HomeController>();
    listPeriods = homeController.listPeriods ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...listPeriods.map((e) => ListTile(
                onTap: (() {
                  Get.back(result: e);
                }),
                contentPadding: EdgeInsets.all(1.w),
                title: Text(
                  e.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: SizeConfig.textScaleFactor,
                ),
              ))
        ],
      ),
    );
  }
}
