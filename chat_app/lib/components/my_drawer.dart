import 'package:chat_app/auth/auth_service.dart';
import 'package:flutter/material.dart';

import '../pages/settings_page.dart';
import 'drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final auth = AuthService();

  void logout() {
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // header
              DrawerHeader(
                child: Icon(
                  Icons.message,
                  size: 48,
                ),
              ),

              SizedBox(
                height: 25,
              ),

              // note tile
              DrawerTile(
                title: "H O M E",
                leading: Icon(
                  Icons.home,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                onTap: () => Navigator.pop(context),
              ),

              // settings
              DrawerTile(
                title: "S E T T I N G S",
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: DrawerTile(
              title: "L O G O U T",
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
