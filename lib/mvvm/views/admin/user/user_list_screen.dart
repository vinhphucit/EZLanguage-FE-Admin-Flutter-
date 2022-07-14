import 'package:fe_ezlang_admin/core/colors.dart';
import 'package:fe_ezlang_admin/core/dimens.dart';
import 'package:fe_ezlang_admin/enums/shape.dart';
import 'package:fe_ezlang_admin/mvvm/models/user.dart';
import 'package:fe_ezlang_admin/mvvm/views/components/responsive.dart';
import 'package:fe_ezlang_admin/mvvm/views/components/side_menu.dart';
import 'package:fe_ezlang_admin/mvvm/views/components/text_avatar.dart';
import 'package:fe_ezlang_admin/utils/color_utils.dart';
import 'package:intl/intl.dart';

import '../../../view_models/admin/user/user_list_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatefulWidget {
  static final String routeName = 'userlist';
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends UserListVM {
  @override
  void initState() {
    super.initState();
    getUsers();
  }

  _buildMobileData() {
    return ListView.builder(
      itemCount: users?.length ?? 0,
      itemBuilder: (context, index) => Column(
        children: [
          ListTile(
            leading: TextAvatar(
              size: 35,
              backgroundColor: Colors.white,
              textColor: Colors.white,
              fontSize: 14,
              upperCase: true,
              numberLetters: 1,
              shape: Shape.Circular,
              text: users[index].firstName!,
            ),
            title: Text(users![index].email!),
            subtitle: Text((users![index].firstName ?? '') +
                " " +
                (users![index].lastName ?? '')),
            trailing: Container(
              width: 230,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      width: 80,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color:
                            getStatusColor(users[index].status).withOpacity(.2),
                        border: Border.all(
                            color: getStatusColor(users[index].status)),
                        borderRadius: BorderRadius.all(Radius.circular(5.0) //
                            ),
                      ),
                      child: Text(
                        users[index].status!,
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    child: Text('View', style: TextStyle(color: greenColor)),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  TextButton(
                    child: Text("Delete",
                        style: TextStyle(color: Colors.redAccent)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                                title: Center(
                                  child: Column(
                                    children: [
                                      Icon(Icons.warning_outlined,
                                          size: 36, color: Colors.red),
                                      SizedBox(height: 20),
                                      Text("Confirm Deletion"),
                                    ],
                                  ),
                                ),
                                content: Container(
                                  color: secondaryColor,
                                  height: 70,
                                  child: Column(
                                    children: [
                                      Text(
                                          "Are you sure want to delete '${users[index].email}'?"),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton.icon(
                                              icon: Icon(
                                                Icons.close,
                                                size: 14,
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.grey),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              label: Text("Cancel")),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          ElevatedButton.icon(
                                              icon: Icon(
                                                Icons.delete,
                                                size: 14,
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red),
                                              onPressed: () {},
                                              label: Text("Delete"))
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                          });
                    },
                    // Delete
                  ),
                ],
              ),
            ),
            onTap: () {},
          ),
          Divider()
        ],
      ),
    );
  }

  _buildWebData() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        //scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: double.infinity,
          child: DataTable(
            horizontalMargin: 0,
            columnSpacing: defaultPadding,
            dataRowHeight: 60,
            columns: [
              DataColumn(
                label: Text(""),
              ),
              DataColumn(
                label: Text("User"),
              ),
              DataColumn(
                label: Text("Role"),
              ),
              DataColumn(
                label: Text("Registration Date"),
              ),
              DataColumn(
                label: Text("Status"),
              ),
              DataColumn(
                label: Text("Operation"),
              ),
            ],
            rows: List.generate(
              users.length,
              (index) => _webUserDataRow(users[index], context),
            ),
          ),
        ),
      ),
    );
  }

  _webUserDataRow(UserModel user, BuildContext context) {
    return DataRow(cells: [
      DataCell(TextAvatar(
        size: 35,
        backgroundColor: Colors.white,
        textColor: Colors.white,
        fontSize: 14,
        upperCase: true,
        numberLetters: 1,
        shape: Shape.Circular,
        text: user.firstName!,
      )),
      DataCell(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 4,
          ),
          Text(
            user.email!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            user.firstName ?? '' + (user.lastName ?? ''),
          ),
          SizedBox(
            height: 4,
          )
        ],
      )),
      DataCell(Text(user.roles?.map((e) => e.name)?.join(',') ?? '')),
      DataCell(Text(
          DateFormat('dd-MM-yyyy').format(DateTime.parse(user.createdAt!)))),
      DataCell(Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: getStatusColor(user.status).withOpacity(.2),
            border: Border.all(color: getStatusColor(user.status)),
            borderRadius: BorderRadius.all(Radius.circular(5.0) //
                ),
          ),
          child: Text(user.status!))),
      DataCell(
        Row(
          children: [
            TextButton(
              child: Text('View', style: TextStyle(color: greenColor)),
              onPressed: () {},
            ),
            SizedBox(
              width: 6,
            ),
            TextButton(
              child: Text("Delete", style: TextStyle(color: Colors.redAccent)),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                          title: Center(
                            child: Column(
                              children: [
                                Icon(Icons.warning_outlined,
                                    size: 36, color: Colors.red),
                                SizedBox(height: 20),
                                Text("Confirm Deletion"),
                              ],
                            ),
                          ),
                          content: Container(
                            color: secondaryColor,
                            height: 70,
                            child: Column(
                              children: [
                                Text(
                                    "Are you sure want to delete '${user.email}'?"),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton.icon(
                                        icon: Icon(
                                          Icons.close,
                                          size: 14,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.grey),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        label: Text("Cancel")),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton.icon(
                                        icon: Icon(
                                          Icons.delete,
                                          size: 14,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red),
                                        onPressed: () {},
                                        label: Text("Delete"))
                                  ],
                                )
                              ],
                            ),
                          ));
                    });
              },
              // Delete
            ),
          ],
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // We want this side menu only for large screen
          if (Responsive.isDesktop(context))
            Expanded(
              // default flex = 1
              // and it takes 1/6 part of the screen
              child: SideMenu(),
            ),
          Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : (Responsive.isMobile(context)
                      ? _buildMobileData()
                      : _buildWebData())),
        ],
      ),
    ));
  }
}
