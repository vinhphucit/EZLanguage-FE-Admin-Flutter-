import 'package:fe_ezlang_admin/components/text_avatar.dart';
import 'package:fe_ezlang_admin/core/constants/colors.dart';
import 'package:fe_ezlang_admin/core/constants/dimens.dart';
import 'package:fe_ezlang_admin/core/utils/color_utils.dart';
import 'package:fe_ezlang_admin/enums/shape.dart';
import 'package:fe_ezlang_admin/models/user.dart';
import 'package:flutter/material.dart';
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
      DataCell(Text(user.roles?.map((e) => e.name).join(',') ?? '')),
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
              onPressed: () {},
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
