import 'package:flutter/material.dart';
import 'package:lost_and_found/screens/deshboard.dart';
import 'package:lost_and_found/dto/User.dart';
import 'package:lost_and_found/services/itemService.dart';
import 'package:lost_and_found/services/userService.dart';

class LostItemView extends StatefulWidget {
  @override
  _LostItemViewState createState() => _LostItemViewState();
}

class _LostItemViewState extends State<LostItemView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    X();
  }

  void X() async {
    User user = await UserService().loginUser("1", "1");
    await ItemService().getLostItems(user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Text("Dash Board ")),
            Expanded(
                child: Container(
              width: 30,
              height: 30,
              child: FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: Color(0xFFFB9932),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashBoard(
                                user: User(),
                              )));
                },
              ),
            ))
          ],
        ),
      ),
      body: MyCustomCard(),
    );
  }
}

class MyCustomCard extends StatelessWidget {
  MyCustomCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        child: Card(
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.album),
                title: Text('The Enchanted Nightingale'),
                subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('BUY TICKETS'),
                    onPressed: () {/* ... */},
                  ),
                  FlatButton(
                    child: const Text('LISTEN'),
                    onPressed: () {/* ... */},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
