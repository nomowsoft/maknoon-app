import 'package:flutter/material.dart';
import 'package:maknoon/controller/home_controller.dart';
import 'package:maknoon/model/core/center_test/test_branch.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';
import 'package:get/get.dart'; 

class SelectTestBranch extends StatefulWidget {
  const SelectTestBranch({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectTestBranch> createState() => _SelectTestBranchState();
}

class _SelectTestBranchState extends State<SelectTestBranch> {
  late List<TestBranch> listTestBranches;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    HomeController homeController = Get.find<HomeController>();
    listTestBranches = homeController.listTestbranchs??[];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...listTestBranches.map((e) => InkWell(
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
                              e.branchName ,
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
