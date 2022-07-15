import 'package:fe_ezlang_admin/components/text_avatar.dart';
import 'package:fe_ezlang_admin/core/colors.dart';
import 'package:fe_ezlang_admin/enums/shape.dart';
import 'package:fe_ezlang_admin/providers/user_list_view_model.dart';
import 'package:fe_ezlang_admin/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class MobileUserList extends StatelessWidget {
  const MobileUserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserListVM>(
      builder: (context, vm, child) => ListView.builder(
        itemCount: vm.users.length ?? 0,
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
                text: vm.users[index].firstName!,
              ),
              title: Text(vm.users[index].email!),
              subtitle: Text((vm.users[index].firstName ?? '') +
                  " " +
                  (vm.users[index].lastName ?? '')),
              trailing: Container(
                width: 230,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        width: 80,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: getStatusColor(vm.users[index].status)
                              .withOpacity(.2),
                          border: Border.all(
                              color: getStatusColor(vm.users[index].status)),
                          borderRadius: BorderRadius.all(Radius.circular(5.0) //
                              ),
                        ),
                        child: Text(
                          vm.users[index].status!,
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
                                            "Are you sure want to delete '${vm.users[index].email}'?"),
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
      ),
    );
  }
}
