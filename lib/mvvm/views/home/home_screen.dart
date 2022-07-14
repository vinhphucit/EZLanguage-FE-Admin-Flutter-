import 'package:fe_ezlang_admin/mvvm/view_models/components/header_view_model.dart';
import 'package:fe_ezlang_admin/mvvm/views/components/responsive.dart';
import 'package:fe_ezlang_admin/mvvm/views/components/side_menu.dart';
import 'package:fe_ezlang_admin/mvvm/views/dashboard/view/dash_board_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static final String routeName = 'home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Provider.of<HeaderVM>(context).scaffoldKey,
      drawer: SideMenu(),
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
              child: DashBoardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
