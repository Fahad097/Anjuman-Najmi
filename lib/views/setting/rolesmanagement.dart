import 'package:anjuman_e_najmi/logic/cubit/role/role_state.dart';
import 'package:anjuman_e_najmi/utils/asset_config.dart';
import 'package:anjuman_e_najmi/utils/landscape_mode.dart';
import 'package:anjuman_e_najmi/views/setting/page_access_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/role/role_cubit.dart';
import '../../routes/routes_names.dart';
import '../../utils/global_constants.dart';
import '../authentication/components/asset_provider.dart';

class RolesManagement extends StatefulWidget {
  RolesManagement({Key? key, this.add}) : super(key: key);

  final String? add;

  @override
  _RolesManagementState createState() => _RolesManagementState();
}

class _RolesManagementState extends State<RolesManagement> {
  bool value = false;
  bool btncheck = false;
  bool isloading = false;
  void _loadData() async {
    await BlocProvider.of<RoleCubit>(context).permission(widget.add.toString());
    await BlocProvider.of<RoleCubit>(context).initializeDropDown();
    String code = BlocProvider.of<RoleCubit>(context)
            .state
            .rolepermissionList?[index]
            .code ??
        "";
    BlocProvider.of<RoleCubit>(context).addTempRole(code, '');
  }

  void initState() {
    _loadData();
    super.initState();
  }

  final GlobalKey<FormState> roleKey = GlobalKey<FormState>();
  int index = 0;
  final pageList = PageAccessModel.fetchAll();
  String selectedValue = "No Access";
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

  String dropdownValue = 'No Access';
  String shownItem = "Admin";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: PreferredSize(
            preferredSize: Size(
                Globals.getDeviceWidth(context),
                isLandscape(context)
                    ? Globals.getDeviceHeight(context) * 0.36
                    : Globals.getDeviceHeight(context) * 0.21),
            child: AppBar(
              actions: [
                PopupMenuButton(
                    padding: EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    icon: ImageIcon(
                      AssetImage(AssetConfig.kMoreIcon),
                      color: Colors.white,
                    ),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem<int>(
                            value: 1,
                            child: Row(
                              children: [
                                AssetProvider(
                                    asset: "assets/user_icon.png",
                                    width: 20,
                                    height: 20,
                                    color: Color(0xff717171)),
                                SizedBox(
                                  width: 3,
                                ),
                                Text("Profile",
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      color: Globals.kUniversalColor,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            )),
                      ];
                    },
                    onSelected: (value) {
                      if (value == 0) {
                        Navigator.pushNamed(context, rolesManagement);
                      } else if (value == 1) {
                        Navigator.pushNamed(context, profile);
                      } else if (value == 2) {
                        print("Logout menu is selected.");
                      }
                    })
              ],
              leading: IconButton(
                onPressed: () {
                  BlocProvider.of<RoleCubit>(context).getUserRole(context);
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              title: Text(
                "Add Role Access",
                style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 22),
              ),
              centerTitle: true,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[Color(0xff233C7E), Color(0xff456BD0)])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: isLandscape(context)
                          ? Globals.getDeviceHeight(context) * 0.18
                          : Globals.getDeviceHeight(context) * 0.09,
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                          onChanged: (val) {},
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            focusColor: Color(0xffE4F9E8),
                            border: InputBorder.none,
                            hintText: "Search",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xff9E9D9D),
                                fontSize: 14),
                            helperStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            suffixIconConstraints:
                                BoxConstraints(minWidth: 25, minHeight: 25),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(left: 5, right: 15),
                              child: ImageIcon(
                                AssetImage(AssetConfig.ksearchIcon),
                                color: Color(0xff9E9D9D),
                                size: 20,
                              ),
                            ),
                            prefixIconColor: Color(0xff9E9D9D),
                          )),
                    ),
                  ],
                ),
              ),
            )),
        body: BlocBuilder<RoleCubit, RoleState>(
          builder: (context, state) {
            print(state.selectedDropdownValues?.length);
            print(widget.add);
            if (state.selectedDropdownValues?.length == 0)
              return Center(
                  child: CircularProgressIndicator(
                color: Globals.kUniversalColor,
              ));
            else
              return SingleChildScrollView(
                child: Form(
                  key: roleKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: Globals.getDeviceHeight(context) * 0.03,
                      ),
                      editRowtext(
                          context,
                          "Role: ",
                          (value) => value.isNotEmpty &&
                                  value != "" &&
                                  value.trim().length <= 20
                              ? context.read<RoleCubit>().addrole(value)
                              : print("$value"), (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Add Role is required';
                        }
                        if (value.trim().length > 20) {
                          return 'Dont Exceed the text Limit';
                        }
                        return null;
                      }),
                      Divider(
                        color: Color(0xff6788DF),
                        thickness: 1,
                        indent: 60,
                        endIndent: 60,
                      ),
                      SizedBox(
                        height: Globals.getDeviceHeight(context) * 0.02,
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Column(
                          children: [
                            ListView.separated(
                              separatorBuilder: (context, index) => Row(),
                              itemCount: state.rolepermissionList?.length ?? 0,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(top: 20),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                      color: index <
                                              (state.rolepermissionList
                                                          ?.length ??
                                                      0) -
                                                  1
                                          ? Colors.grey.shade300
                                          : Colors.transparent,
                                      width: index <
                                              (state.rolepermissionList
                                                          ?.length ??
                                                      0) -
                                                  1
                                          ? 1.0
                                          : 0),
                                )),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    trailing: Container(
                                      width: 150,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          onChanged: (newValue) {
                                            String code = state
                                                    .rolepermissionList?[index]
                                                    .code ??
                                                "";
                                            print('Fahad' + code);

                                            BlocProvider.of<RoleCubit>(context)
                                                .addTempRole(
                                                    code, newValue.toString());

                                            BlocProvider.of<RoleCubit>(context)
                                                .updateDropdown(
                                                    index, newValue!);
                                          },

                                          icon: ImageIcon(
                                            AssetImage(
                                                AssetConfig.kdropdownIcon),
                                            color: Color(0xff86A3F0),
                                            size: 12,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          //   value: dropdownItems,
                                          // value: dropdownItems[0].value,
                                          value: state.selectedDropdownValues?[
                                                  index] ??
                                              "",
                                          // value: dropdownItems[stringToIndex[
                                          // selectedDropdownValues[index]]],
                                          items: dropdownItems,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      state.rolepermissionList?[index].name ??
                                          "Null",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Color(0xff233C7E),
                                Color(0xff456BD0)
                              ])),
                          child: MaterialButton(
                            height: 50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            minWidth: MediaQuery.of(context).size.width * 0.8,
                            onPressed: (isloading == false)
                                ? () async {
                                    if (roleKey.currentState!.validate()) {
                                      setState(() {
                                        isloading = true;
                                      });
                                      await context
                                          .read<RoleCubit>()
                                          .addUserRole(context);
                                    }
                                  }
                                : null,
                            child: (isloading == false)
                                ? Text(
                                    "Add Role",
                                    style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontSize: 16),
                                  )
                                : CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
          },
        ));
  }
}

Widget editRowtext(context, String title, Function(String) onChanged,
    String? Function(String?) validator) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: Globals.getDeviceWidth(context) * 0.15,
            child: Text(title,
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  color: Color(0xff676767),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
          ),
          SizedBox(
            width: Globals.getDeviceWidth(context) * 0.35,
            child: TextFormField(
              keyboardType: TextInputType.text,
              onChanged: onChanged,
              validator: validator,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: "Role",
                hintStyle: TextStyle(
                  fontFamily: 'Helvetica',
                  color: Globals.kFiledColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                // contentPadding: EdgeInsets.all(17),
              ),
            ),
          )
        ],
      ),
      SizedBox(
        height: Globals.getDeviceHeight(context) * 0.03,
      )
    ],
  );
}
