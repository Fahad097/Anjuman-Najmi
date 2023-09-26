import 'package:anjuman_e_najmi/utils/global_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeTile extends StatelessWidget {
  final String assets;
  final String title;
  final String subtitle;
  final Function() ontap;

  HomeTile(
      {super.key,
      required this.assets,
      required this.title,
      required this.ontap,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: kIsWeb ? 100 : 85,
        child: Card(
          color: Color(0xffF8F8F8),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 60,
                    width: 60,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Image.asset(assets)),
                SizedBox(
                  width: Globals.getDeviceWidth(context) * 0.04,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    //   Container(
    //     padding: EdgeInsets.all(15),
    //     height: 100,
    //     width: double.infinity,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(14),
    //       color: Color(0xffF8F8F8),
    //       boxShadow: <BoxShadow>[
    //         // BoxShadow(
    //         //   color: Globals.kUniversalColor,
    //         //   offset: Offset(0.0, 0.75),
    //         // )
    //         BoxShadow(
    //             color: Colors.grey,
    //             offset: Offset(0, 2.2), // hide shadow top
    //             blurRadius: 5),
    //         BoxShadow(
    //           color: Colors.white, // replace with color of container
    //           offset: Offset(-8, 0), // hide shadow right
    //         ),
    //         BoxShadow(
    //           color: Colors.white, // replace with color of container
    //           offset: Offset(8, 0), // hide shadow left
    //         ),
    //       ],
    //     ),
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Container(
    //           height: 55,
    //           width: 80,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(20),
    //             color: Colors.white,
    //           ),
    //           child: AssetProvider(
    //             asset: assets,
    //             color: Globals.kUniversalColor,
    //             width: 20,
    //             height: 20,
    //           ),
    //         ),
    //         SizedBox(
    //           width: Globals.getDeviceWidth(context) * 0.02,
    //         ),
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               title,
    //               style: TextStyle(  fontFamily: 'Helvetica',
    //                 color: Colors.black,
    //                 fontSize: 22,
    //                 fontWeight: FontWeight.w400,
    //               ),
    //             ),
    //             Text(
    //               subtitle,
    //               style: TextStyle(  fontFamily: 'Helvetica',
    //                 color: Color(0xff9E9D9D),
    //                 fontSize: 14,
    //                 fontWeight: FontWeight.w400,
    //               ),
    //             )
    //           ],
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
