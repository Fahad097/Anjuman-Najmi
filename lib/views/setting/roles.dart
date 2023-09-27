import 'package:anjuman_e_najmi/data/model/permission.dart';
import 'package:anjuman_e_najmi/logic/cubit/role/role_cubit.dart';
import 'package:anjuman_e_najmi/logic/cubit/role/role_state.dart';
import 'package:anjuman_e_najmi/views/setting/components/collapse_button.dart';
import 'package:anjuman_e_najmi/views/setting/editroleAccess.dart';
import 'package:anjuman_e_najmi/views/setting/rolesmanagement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../routes/routes_names.dart';
import '../../utils/asset_config.dart';
import '../../utils/global_constants.dart';
import '../../utils/landscape_mode.dart';
import '../authentication/components/asset_provider.dart';

class Roles extends StatefulWidget {
  @override
  State<Roles> createState() => _RolesState();
}

class _RolesState extends State<Roles> {
  final roleCubit = RoleCubit();
  bool isloading = false;
  _getUser() async {
    await BlocProvider.of<RoleCubit>(context).getUserRole(context);
    setState(() {
      isloading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  bool hasWriteRole = permissionService.hasWritePermission('app.user_role');
  bool hasWriteRead = permissionService.hasReadPermission('app.user_role');
  bool hasWriteUser = permissionService.hasWritePermission('app.user');
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
              if (hasWriteUser)
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
                                Text("AddUser",
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
                        Navigator.pushNamed(context, addUser);
                      } else if (value == 2) {
                        print("Logout menu is selected.");
                      }
                    })
            ],
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            title: Text(
              "Roles Management",
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
          return SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Roles",
                          style: TextStyle(
                              fontFamily: 'Helvetica',
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(69, 107, 208, 1)),
                        ),
                        if (hasWriteRole)
                          FloatingActionButton(
                              child: ImageIcon(
                                  AssetImage(AssetConfig.kReceiptIcon)),
                              backgroundColor: Globals.kUniversalColor,
                              onPressed: () {
                                BlocProvider.of<RoleCubit>(context)
                                    .permission("Add Role");
                                state.permission?.clear();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => RolesManagement(
                                              add: "Add Role",
                                            )));
                              }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  (isloading == false)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                                color: Colors.transparent,
                                height: 10,
                              ),
                          itemCount: state.userRole?.length ?? 0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          itemBuilder: (context, index) => Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width:
                                        Globals.getDeviceWidth(context) * 0.90,
                                    height:
                                        Globals.getDeviceHeight(context) * 0.08,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(29)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // const SizedBox(
                                          // width: 30,
                                          // ),
                                          Text(
                                            //    state.roles?[index].name ??
                                            //     "NULL",
                                            state.userRole![index].name ?? "",
                                            style: TextStyle(
                                                fontFamily: 'Helvetica',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          if (hasWriteRole)
                                            CollapseButton(
                                              onTapDEL: () async {
                                                await context
                                                    .read<RoleCubit>()
                                                    .deleteUserRole(
                                                        context,
                                                        state.userRole![index]
                                                            .id!);
                                                await context
                                                    .read<RoleCubit>()
                                                    .getUserRole(context);
                                              },
                                              onEditTap: () {
                                                state.permission!.clear();
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            EditRoleAccess(
                                                              add: "Update",
                                                              id: state
                                                                  .userRole?[
                                                                      index]
                                                                  .id,
                                                              name: state
                                                                  .userRole?[
                                                                      index]
                                                                  .name,
                                                            )));

                                                debugPrint(state
                                                    .userRole?[index].id
                                                    .toString());
                                              },
                                            ),
                                          if (hasWriteRead)
                                            InkWell(
                                              onTap: () {
                                                state.permission!.clear();
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            EditRoleAccess(
                                                              add: "Update",
                                                              id: state
                                                                  .userRole?[
                                                                      index]
                                                                  .id,
                                                              name: state
                                                                  .userRole?[
                                                                      index]
                                                                  .name,
                                                            )));

                                                debugPrint(state
                                                    .userRole?[index].id
                                                    .toString());
                                              },
                                              child: CustomPaint(
                                                  size: Size(26,
                                                      26), // Set the size of the canvas
                                                  painter: CirclePainter(),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Icon(
                                                      Icons.arrow_back_rounded,
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  index == (state.roles?.length ?? 0) - 1
                                      ? const SizedBox(
                                          height: 20,
                                        )
                                      : const SizedBox()
                                ],
                              )),
                ]),
          ));
        },
      ),
    );
  }
}
