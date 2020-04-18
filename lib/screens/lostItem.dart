import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:lost_and_found/dto/User.dart';
import 'package:lost_and_found/services/itemService.dart';
import 'package:lost_and_found/services/uploadService.dart';
import 'package:lost_and_found/screens/loading.dart';
import 'package:lost_and_found/screens/deshboard.dart';
/*
* Item Service base url https://itemservice.herokuapp.com
* */

class LostItem extends StatefulWidget {
  LostItem({this.user, this.pics});
  final List<File> pics;
  final User user;
  @override
  _LostItemState createState() => _LostItemState(user: user, images: pics);
}

class _LostItemState extends State<LostItem> {
  _LostItemState({this.user, this.images});
  User user;
  List<File> images;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  UploadService uploadService = UploadService();
  TextStyle styleCountGreen = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 30.0,
    color: Colors.green[900],
  );
  TextStyle styleCountRed = TextStyle(
      fontFamily: 'Montserrat', fontSize: 30.0, color: Colors.red[900]);
  List<Widget> get() {
    List<Widget> I = List<Widget>();
    images.forEach((file) {
      I.add(Expanded(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Image.file(file),
            ),
            Expanded(
              flex: 4,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    images.remove(file);
                  });
                },
                child: Icon(
                  Icons.close,
                  color: Colors.red[300],
                  size: 40,
                ),
              ),
            )
          ],
        ),
      ));
    });
    return I;
  }

  Future getImageFromCamera() async {
    if (images.length == 6) return;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoadingScreen(
              message: "Uploading Camera ",
              task: () async {
                var image =
                    await ImagePicker.pickImage(source: ImageSource.camera);
                images.add(image);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LostItem(
                      user: this.user,
                      pics: this.images,
                    ),
                  ),
                );
              }),
        ));
  }

  Future getImageFromGallery() async {
    if (images.length == 6) return;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoadingScreen(
              message: "Uploading Gallery",
              task: () async {
                var image =
                    await ImagePicker.pickImage(source: ImageSource.gallery);
                images.add(image);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LostItem(
                      user: this.user,
                      pics: this.images,
                    ),
                  ),
                );
              }),
        ));
  }

  Future<void> upload() async {
    if (images == null || images.length == 0) {
      print("No image selected");
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LoadingScreen(
                message: "Saving Images",
                task: () async {
                  List<String> imageUrls = List<String>();
                  for (File f in images) {
                    dynamic s = await uploadService.uploadFile(f);
                    imageUrls.add(s.toString());
                  }
                  print("calling item Service");
                  ItemService itemService = ItemService();
                  print("Image Urls : " + imageUrls.toString());
                  await itemService.saveLostItem(user, imageUrls);
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashBoard(
                                user: user,
                                message:
                                    "Lost Item Saved Successfully Will Get in touch soon",
                                color: Colors.green[900],
                              )));
                },
              )),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int upLoaded = images.length;
    int pending = 6 - images.length;
    print("Logged in user " + user.id);
    print("Images recived " + images.length.toString());
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
              child: images.isEmpty
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
                          "$pending",
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
            child: images.isEmpty
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
                  child: GestureDetector(
                    onTap: getImageFromGallery,
                    child: Icon(
                      Icons.add_photo_alternate,
                      size: 50,
                    ),
                  ),
                ),
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
