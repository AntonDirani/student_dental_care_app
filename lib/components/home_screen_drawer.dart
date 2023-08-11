import 'package:flutter/material.dart';
import 'package:student_care_app/resources/assets_manager.dart';

class HomeScreenDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageAssetsManager.emailIcon))),
          ),
        ),
        ListTile(
          subtitle: Text('Show all trips'),
        ),
      ],
    ));
  }
}
