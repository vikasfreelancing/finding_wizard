import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:lost_and_found/dto/User.dart';
import 'package:lost_and_found/services/itemService.dart';
import 'package:lost_and_found/services/uploadService.dart';
/*
* Item Service base url https://itemservice.herokuapp.com
* */

class FoundItem extends StatefulWidget {
  FoundItem({this.user});
  final User user;
  @override
  _FoundItemState createState() => _FoundItemState(user: user);
}

class _FoundItemState extends State<FoundItem> {
  _FoundItemState({this.user});
  User user;
  File image;
  String imageUrl = "";
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  UploadService uploadService = UploadService();
  TextStyle styleCountGreen = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 30.0,
    color: Colors.green[900],
  );
  TextStyle styleCountRed = TextStyle(
      fontFamily: 'Montserrat', fontSize: 30.0, color: Colors.red[900]);
  Future getImageFromCamera() async {
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      isUploaded = true;
    });
  }

  Future<void> upload() async {
    dynamic s = await uploadService.uploadFile(f);
    imageUrl = s.toString();
    print("calling item Service");
    ItemService itemService = ItemService();
    print(imageUrl);
    await itemService.saveItem(user, imageUrl);
    print(itemService.responseCode);
    print(itemService.data);
  }

  @override
  void initState() {
    super.initState();
  }

  bool isUploaded = false;
  @override
  Widget build(BuildContext context) {
    print(user.id);
    final uploadButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          print("uploading");
          await upload();
          print("////// image urlls");
          print(imageUrls);
        },
        child: Text("Upload",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Color(0xff685EF2), fontWeight: FontWeight.bold)),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Lost Item'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Center(
              child: _images.isEmpty
                  ? Text(
                      "Please Select 6 Images of lost Item",
                      style: style,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "$upLoaded ",
                          style: styleCountGreen,
                        ),
                        Text(
                          "Uploaded ",
                          style: style,
                        ),
                        Text(
                          "$panding",
                          style: styleCountRed,
                        ),
                        Text(
                          "Pending",
                          style: style,
                        )
                      ],
                    ),
            ),
          ),
          Expanded(
            flex: 8,
            child: _images.isEmpty
                ? Center(
                    child: Text(
                      "No Image selected",
                      style: styleCountRed,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: get(),
                    ),
                  ),
          ),
          Expanded(
            flex: 5,
            child: Center(
                child: Row(
              children: <Widget>[
                Expanded(
                  child: uploadButton,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: getImageFromCamera,
                    child: Icon(
                      Icons.camera,
                      size: 50,
                    ),
                  ),
                ),
              ],
            )),
          )
        ],
      )),
    );
  }
}
