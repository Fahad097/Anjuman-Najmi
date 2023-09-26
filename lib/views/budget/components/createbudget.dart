import 'package:anjuman_e_najmi/utils/global_constants.dart';
import 'package:anjuman_e_najmi/views/authentication/components/asset_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubit/usermanaged/usermanaged_cubit.dart';
import '../../../utils/asset_config.dart';
import '../../setting/models/userlist_model.dart';

class CreateBudget extends StatefulWidget {
  CreateBudget({super.key});

  @override
  State<CreateBudget> createState() => _CreateBudgetState();
}

class _CreateBudgetState extends State<CreateBudget> {
  final int index = 0;

  final int i = 1;

  final userlist = Userlistmodel.fetchAll();

  List<DropdownMenuItem<String>> get dropdowncategoryItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Category 1"), value: "Category 1"),
      DropdownMenuItem(child: Text("Category 2"), value: "Category 2"),
      DropdownMenuItem(child: Text("Category 3"), value: "Category 3"),
    ];

    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownyearItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("2019"), value: "2019"),
      DropdownMenuItem(child: Text("2018"), value: "2018"),
      DropdownMenuItem(child: Text("2017"), value: "2015"),
    ];

    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserManagedCubit, UserManagedState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("Create Budget",
                //     style: TextStyle(
                //         fontFamily: 'Helvetica',
                //         fontWeight: FontWeight.w400,
                //         color: Color(0xff4A4A4A),
                //         fontSize: 22)),
                // SizedBox(
                //   height: Globals.getDeviceHeight(context) * 0.02,
                // ),
                DropdownButtonFormField(
                    hint: Text("Select year"),
                    icon: ImageIcon(
                      AssetImage(AssetConfig.kdropdownIcon),
                      color: Colors.grey,
                      size: 16,
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(13),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        // filled: true,
                        fillColor: Globals.kFiledColor),
                    validator: (value) => value == null ? "Select year" : null,
                    value: "2019",
                    style: TextStyle(
                      fontFamily: 'Helvetica',
                      color: Color(0xff6D6D6D),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    onChanged: (value) {},
                    items: dropdownyearItems),
                SizedBox(
                  height: Globals.getDeviceHeight(context) * 0.02,
                ),
                DropdownButtonFormField(
                    hint: Text("Select Category"),
                    icon: ImageIcon(
                      AssetImage(AssetConfig.kdropdownIcon),
                      color: Colors.grey,
                      size: 16,
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(13),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        // filled: true,
                        fillColor: Globals.kFiledColor),
                    validator: (value) =>
                        value == null ? "Select Category" : null,
                    value: "Category 1",
                    style: TextStyle(
                      fontFamily: 'Helvetica',
                      color: Color(0xff6D6D6D),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    onChanged: (value) {},
                    items: dropdowncategoryItems),
                // SizedBox(
                //   height: Globals.getDeviceHeight(context) * 0.02,
                // ),

                ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.addlist?.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, i) {
                      return Column(
                        children: [
                          SizedBox(
                            height: Globals.getDeviceHeight(context) * 0.02,
                          ),
                          Row(
                            children: [
                              Text("Item $i",
                                  style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff4A4A4A),
                                      fontSize: 22)),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  print("#ww $i");
                                  // BlocProvider.of<UserManagedCubit>(context)
                                  //     .delete(i);
                                  setState(() {
                                    state.addlist?.removeAt(i);
                                  });
                                },
                                child: AssetProvider(
                                  asset: "assets/remove.png",
                                  width: 35,
                                  height: 35,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: Globals.getDeviceHeight(context) * 0.02,
                          ),
                          TextFormField(
                            initialValue:
                                state.addlist![i]['amount'].toString(),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.number,
                            // validator: (val) {
                            //   if (val!.isEmpty) {
                            //     return "Amount is required";
                            //   }
                            //   return val;
                            // },
                            onChanged: (val) {
                              BlocProvider.of<UserManagedCubit>(context)
                                  .amount(int.parse(val));
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Amount",
                              hintStyle: TextStyle(
                                fontFamily: 'Helvetica',
                                color: Globals.kFiledColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              contentPadding: EdgeInsets.all(17),
                            ),
                          ),
                          SizedBox(
                            height: Globals.getDeviceHeight(context) * 0.02,
                          ),
                          TextFormField(
                            initialValue: state.addlist![i]['remarks'],
                            keyboardType: TextInputType.text,
                            // validator: (val) {
                            //   if (val!.isEmpty ) {
                            //     return "Remarks is required";
                            //   }
                            //   return val;
                            // },
                            onChanged: (val) {
                              BlocProvider.of<UserManagedCubit>(context)
                                  .remarks(val);
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Remarks",
                              hintStyle: TextStyle(
                                fontFamily: 'Helvetica',
                                color: Globals.kFiledColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              contentPadding: EdgeInsets.all(17),
                            ),
                          ),
                        ],
                      );
                    }),
                SizedBox(
                  height: Globals.getDeviceHeight(context) * 0.02,
                ),
                InkWell(
                  onTap: () {
                    state.addcheck!
                        ? BlocProvider.of<UserManagedCubit>(context)
                            .addListitem(isCheck: true)
                        : context
                            .read<UserManagedCubit>()
                            .addListitem(isCheck: false);
                  },
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: AssetProvider(
                      asset: AssetConfig.kadd_Icon,
                      width: 55,
                      height: 55,
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          colors: [Color(0xff233C7E), Color(0xff456BD0)])),
                  child: MaterialButton(
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minWidth: double.infinity,
                    onPressed: () {},
                    child: Text(
                      "Save",
                      style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
