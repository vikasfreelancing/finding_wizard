import 'package:flutter/material.dart';
import 'package:lost_and_found/dto/User.dart';
import 'package:lost_and_found/model/LostItem.dart';
import 'package:lost_and_found/screens/lostItemViewList.dart';
import 'package:lost_and_found/screens/loading.dart';
import 'package:lost_and_found/services/itemService.dart';

class NavDrawer extends StatefulWidget {
  NavDrawer({this.user});
  final User user;
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  User user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = widget.user;
  }

  void loadData() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoadingScreen(
          message: "Loading Data ",
          task: () async {
            List<LostItem> items = await ItemService().getLostItems(user.id);
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LostItemView(
                          items: items,
                          user: user,
                        )));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('logo2.png'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.inbox),
            title: Text('View Requests'),
            onTap: () {
              loadData();
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
        ],
      ),
    );
  }
}
