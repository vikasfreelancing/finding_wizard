import 'package:flutter/material.dart';
import 'package:lost_and_found/constants/constants.dart';
import 'package:lost_and_found/screens/lostItem.dart';
import 'package:lost_and_found/services/userService.dart';
import 'package:lost_and_found/dto/User.dart';

class DashBoard extends StatefulWidget {
  final User user;
  DashBoard({this.user});
  @override
  _DashBoard createState() => _DashBoard();
}

class _DashBoard extends State<DashBoard> {
  User user;
  @override
  void initState() {
    print("Dash board");
    super.initState();
    user = widget.user;
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    print("dash board build");
    final lostSomething = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LostItem(user: user),
            ),
          );
        },
        child: Text("Lost Something",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 40)),
      ),
    );
    final foundSomething = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          //TODO : render found item
        },
        child: Text("Found Something",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 40)),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome " + user.name, style: kAppNameStyle),
      ),
      body: Center(
        child: Container(
          color: Color(0xFF6D60FB),
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: ListView(
              children: <Widget>[
                Container(
                  width: 155,
                  height: 155,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'Custom-Logos.png',
                  ),
                ),
                SizedBox(height: 150.0),
                lostSomething,
                SizedBox(height: 150.0),
                foundSomething,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
