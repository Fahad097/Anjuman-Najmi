import 'package:anjuman_e_najmi/logic/cubit/access/access_cubit.dart';
import 'package:anjuman_e_najmi/logic/cubit/access/access_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/access_model.dart';
import '../../../utils/asset_config.dart';
import '../../../utils/global_constants.dart';

class AccessOption extends StatefulWidget {
  AccessOption(
      {super.key,
      required this.accessList,
      required this.index,
      required this.parentIndex});

  final List<AccessModel> accessList;
  final int index;
  final int parentIndex;

  @override
  State<AccessOption> createState() => _AccessOptionState();
}

class _AccessOptionState extends State<AccessOption> {
  late final List<AccessModel> accessList;
  late final int parentIndex;
  late final int index;
  String _selectedValue = "No Access";

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {},
                  child: ImageIcon(AssetImage(AssetConfig.knoaccess_Icon),
                      size: 18, color: Color(0xff818181))),
              SizedBox(
                width: 8,
              ),
              Text(
                "No Access",
                style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.w400,
                    color: Color(0xff858585),
                    fontSize: 10),
              ),
            ],
          ),
          value: "n"),
      DropdownMenuItem(
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            ImageIcon(
              AssetImage(AssetConfig.kreadaccess_Icon),
              color: Color(0xff818181),
              size: 18,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "Read Access",
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w400,
                  color: Color(0xff858585),
                  fontSize: 10),
            ),
          ]),
          value: "r"),
      DropdownMenuItem(
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            ImageIcon(AssetImage(AssetConfig.kreadwrite_Icon),
                size: 18, color: Color(0xff818181)),
            SizedBox(
              width: 8,
            ),
            Text(
              "Read-Write Access",
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w400,
                  color: Color(0xff858585),
                  fontSize: 10),
            ),
          ]),
          value: "w"),
    ];

    return menuItems;
  }

  @override
  void initState() {
    accessList = widget.accessList;
    index = widget.index;
    parentIndex = widget.parentIndex;
    _selectedValue = accessList[index].access!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: Globals.getDeviceWidth(context) * 0.4,
          child: Text(
              //"Dashboard",
              accessList[index].name!,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5C5C5C),
                  fontSize: 14)),
        ),
        // SizedBox(
        //   width: Globals.getDeviceWidth(context) * 0.42,
        //   height: 30,
        //   child: BlocBuilder<AccessCubit, AccessState>(
        //     builder: (context, state) {
        //       return DropdownButtonHideUnderline(
        //         child: DropdownButton(
        //             hint: Text("Select"),
        //             icon: ImageIcon(
        //               AssetImage(AssetConfig.kdropdownIcon),
        //               color: Color(0xff86A3F0),
        //               size: 12,
        //             ),
        //             borderRadius: BorderRadius.circular(20),
        //             value: _selectedValue,
        //             style: TextStyle(
        //               fontFamily: 'Helvetica',
        //               color: Color(0xff6D6D6D),
        //               fontSize: 10,
        //               fontWeight: FontWeight.w400,
        //             ),
        //             onChanged: (newValue) {
        //               BlocProvider.of<AccessCubit>(context).updateAccess(
        //                   parentIndex, childIndex: index, newValue!);
        //               setState(() {
        //                 _selectedValue = accessList[index].access!;
        //               });
        //             },
        //             items: dropdownItems),
        //       );
        //     },
        //   ),
        // ),
        SizedBox(
          width: Globals.getDeviceWidth(context) * 0.01,
        )
      ],
    );
  }
}
