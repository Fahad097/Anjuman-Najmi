import 'package:anjuman_e_najmi/utils/landscape_mode.dart';
import 'package:flutter/material.dart';
import '../../utils/global_constants.dart';

class BudgetReport extends StatelessWidget {
  BudgetReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              height: 50,
              child: Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Globals.getDeviceWidth(context) * 0.19,
                      child: Text(
                        "Item List",
                        style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.w400,
                            color: Color(0xff5978C8),
                            fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      width: Globals.getDeviceWidth(context) * 0.15,
                      child: Text(
                        "Actual",
                        style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.w400,
                            color: Color(0xff5978C8),
                            fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      width: Globals.getDeviceWidth(context) * 0.23,
                      child: Text(
                        "Budgeted",
                        style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.w400,
                            color: Color(0xff5978C8),
                            fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      width: Globals.getDeviceWidth(context) * 0.12,
                      child: Text(
                        "Left",
                        style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.w400,
                            color: Color(0xff5978C8),
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.transparent,
                      height: 10,
                    ),
                itemCount: 15,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
                itemBuilder: (context, index) => InkWell(
                      // onTap: () =>
                      //     Navigator.pushNamed(context, rolesManagement),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                offset: const Offset(
                                  5.0,
                                  5.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ),
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: isLandscape(context)
                                  ? Globals.getDeviceWidth(context) * 0.22
                                  : Globals.getDeviceWidth(context) * 0.15,
                              child: Text(
                                "item 1",
                                style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w400,
                                    color: Globals.kUniversalColor,
                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              width: isLandscape(context)
                                  ? Globals.getDeviceWidth(context) * 0.22
                                  : Globals.getDeviceWidth(context) * 0.15,
                              child: Text(
                                "2500",
                                style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w400,
                                    color: Globals.kUniversalColor,
                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              width: isLandscape(context)
                                  ? Globals.getDeviceWidth(context) * 0.22
                                  : Globals.getDeviceWidth(context) * 0.15,
                              child: Text(
                                "3000",
                                style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w400,
                                    color: Globals.kUniversalColor,
                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              width: isLandscape(context)
                                  ? Globals.getDeviceWidth(context) * 0.13
                                  : Globals.getDeviceWidth(context) * 0.15,
                              child: Text(
                                "500",
                                style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w400,
                                    color: Globals.kUniversalColor,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}
