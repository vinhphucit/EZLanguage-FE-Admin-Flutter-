import 'package:fe_ezlang_admin/core/colors.dart';
import 'package:fe_ezlang_admin/core/dimens.dart';
import 'package:fe_ezlang_admin/enums/shape.dart';
import 'package:fe_ezlang_admin/mvvm/models/user.dart';
import 'package:fe_ezlang_admin/mvvm/view_models/admin/user/user_list_view_model.dart';
import 'package:fe_ezlang_admin/mvvm/views/components/text_avatar.dart';
import 'package:fe_ezlang_admin/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WebUserList extends StatelessWidget {
  const WebUserList({Key? key}) : super(key: key);
  _webUserDataRow(UserModel user, BuildContext context) {
    DataRow(cells: [
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
    var users = Provider.of<UserListVM>(context).users;
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
}
