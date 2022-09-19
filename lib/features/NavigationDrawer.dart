import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_tv/features/profile_profile.dart';
import 'package:smart_tv/features/subsscription.dart';
import 'changepasword.dart';
import 'home.dart';






class NavigationDrawer extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.black,
        // ignore: prefer_const_constructors

        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(
              height: 48,
            ),
            buildMenuItem(
              text: 'Profile',
              icon: Icons.person,
              onclicked: () => selctedItem(context,0),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 10,
            ),

            buildMenuItem(
              text: 'Change Password',
              icon: Icons.password,
               onclicked: () => selctedItem(context,1),
          
            ),
            SizedBox(
              height: 10,
            ),
            buildMenuItem(
              text: 'Subscriptions',
              icon: Icons.subscriptions,
               onclicked: () => selctedItem(context,2),
            ),
            SizedBox(
              height: 10,
            ),

            buildMenuItem(
              text: 'Referal program',
              icon: Icons.share,
            ),

            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            buildMenuItem(
              text: 'Invite Freinds',
              icon: Icons.share,
            ),
            SizedBox(
              height: 10,
            ),
            buildMenuItem(
              text: 'About kabbee',
              icon: Icons.perm_device_information,
            ),
            SizedBox(
              height: 10,
            ),
            buildMenuItem(
              text: 'Referal program',
              icon: Icons.privacy_tip,
            ),
            SizedBox(
              height: 10,
            ),
            buildMenuItem(
              text: 'FQA',
              icon: Icons.question_mark,
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            buildMenuItem(
              text: 'Logout',
              icon: Icons.logout,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onclicked,
  }) {
    final color = Colors.white;
    final hovercolor = Colors.white70;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(text, style: TextStyle(color: color)),
      onTap: onclicked,
    );
  }

  void selctedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) =>  Profile()));
            break;
        case 1:
         Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) =>  ChangePassword()));
            break;
             case 2:
         Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) =>  Subscription()));
            break;

    }
  }
}
