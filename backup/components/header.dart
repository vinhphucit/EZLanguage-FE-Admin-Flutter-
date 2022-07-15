import 'package:fe_ezlang_admin/components/responsive.dart';
import 'package:fe_ezlang_admin/providers/header_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
              onPressed: () {
                Provider.of<HeaderVM>(context, listen: false).toggleSideMenu();
              },
              icon: Icon(Icons.menu))
      ],
    );
  }
}
