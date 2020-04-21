import 'package:flutter/material.dart';
import 'package:lost_and_found/model/lostItemDetails.dart' as model;
import 'package:lost_and_found/constants/constants.dart';
import 'package:lost_and_found/widget/mylostcard.dart';

class LostItemDetails extends StatefulWidget {
  LostItemDetails({this.lostItemDetails});
  final model.LostItemDetailsModel lostItemDetails;
  @override
  _LostItemDetailsState createState() => _LostItemDetailsState();
}

class _LostItemDetailsState extends State<LostItemDetails> {
  model.LostItemDetailsModel lostItemDetails;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.lostItemDetails = widget.lostItemDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                "Details of Found Item ",
                style: kAppNameStyle.copyWith(
                    color: Colors.green[900],
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
              padding: EdgeInsets.all(5),
              height: 400,
              child: Card(
                color: Color(0xFFE2DFFE),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.all(3),
                        child: ListTile(
                          leading: Icon(Icons.message),
                          title: Text(
                            'Posted by ${lostItemDetails.user.name}',
                            style: TextStyle(
                                color: Colors.purple[900],
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${lostItemDetails.lostItem.createdAt}',
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 15,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Image.network(lostItemDetails.foundItem.images),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: ButtonBar(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "Image matched with request ",
                                  style: TextStyle(
                                      color: Colors.purple, fontSize: 10),
                                ),
                                FlatButton(
                                  child: Text(
                                    'CONTACT DETAILS',
                                    style: TextStyle(
                                        color: Colors.purple[900],
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                "Details of Lost Item ",
                style: kAppNameStyle.copyWith(
                    color: Colors.red[900],
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: MyLostCard(
              item: lostItemDetails.lostItem,
              viewDetails: false,
            ),
          )
        ],
      )),
    );
  }
}
