import 'package:flutter/material.dart';
import 'package:lost_and_found/dto/User.dart';
import 'package:lost_and_found/services/uploadService.dart';
import 'sideMenu.dart';
import 'package:lost_and_found/screens/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:lost_and_found/services/itemService.dart';

class Profile extends StatefulWidget {
  Profile({this.user});
  final User user;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String updatedProfile;
  User user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.user = widget.user;
    print(user.aadhar);
  }

  Future<void> upload(File image) async {}
  Future getImageFromCamera() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoadingScreen(
                message: "Uploading Camera ",
                task: () async {
                  var image =
                      await ImagePicker.pickImage(source: ImageSource.camera);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoadingScreen(
                              message: "Saving Profile Image",
                              task: () async {
                                dynamic s =
                                    await UploadService().uploadFile(image);
                                String imageUrl = s.toString();
                                print("calling userUpdate Service");
                                user.profileImage = imageUrl;
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile(
                                              user: user,
                                            )));
                              },
                            )),
                  );
                })));
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = TextStyle(fontSize: 15, color: Colors.grey);
    TextStyle _textFieldStyle = TextStyle(
        fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold);
    return Scaffold(
      backgroundColor: Color(0xFFE5DDD5),
      drawer: NavDrawer(
        user: user,
      ),
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Text("Chat")),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 5,
                child: (user.profileImage == null)
                    ? GestureDetector(
                        onTap: () {
                          getImageFromCamera();
                        },
                        child: CircleIcon(),
                      )
                    : CircleImage(
                        imageUrl: user.profileImage,
                      )),
            Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          "Name:",
                          style: _textStyle,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        user.name,
                        style: _textFieldStyle,
                      ),
                    )
                  ],
                )),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        "Email:",
                        style: _textStyle,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      user.email,
                      style: _textFieldStyle,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        "Phone:",
                        style: _textStyle,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      user.phone,
                      style: _textFieldStyle,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        "AADHAAR:",
                        style: _textStyle,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      user.aadhar,
                      style: _textFieldStyle,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        "Password:",
                        style: _textStyle,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      user.password,
                      style: _textFieldStyle,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: FlatButton(
                  child: Text(
                    "Upload Image",
                    style: TextStyle(color: Colors.teal[900]),
                  ),
                  onPressed: (updatedProfile == null)
                      ? null
                      : () {
                          print("Upload Image");
                        },
                  disabledTextColor: Colors.teal[50],
                  color: Colors.grey[900],
                  disabledColor: Colors.grey[50],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CircleImage extends StatelessWidget {
  CircleImage({this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    double _size = 200.0;
    return Center(
      child: new Container(
        width: _size,
        height: _size,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
            fit: BoxFit.fill,
            image: new NetworkImage(imageUrl),
          ),
        ),
      ),
    );
  }
}

class CircleIcon extends StatelessWidget {
  CircleIcon({this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    double _size = 150.0;

    return Center(
      child: new Container(
        child: FlatButton(
          child: Icon(Icons.camera),
        ),
        width: _size,
        height: _size,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
      ),
    );
  }
}