import 'package:flutter/material.dart';
import 'package:lost_and_found/constants/constants.dart';
import 'package:lost_and_found/services/userService.dart';
import 'package:lost_and_found/dto/User.dart';
import 'package:lost_and_found/screens/loading.dart';
import 'login.dart';
import 'package:lost_and_found/constants/logo.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  void registerUser(User user) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoadingScreen(
            message: "Saving Details :",
            task: () async {
              UserService userService = UserService();
              User isRegistered = await userService.registerUser(user);
              Color color;
              if (isRegistered == null ||
                  isRegistered.message == "Registered sucessfully")
                color = Colors.red[900];
              else
                color = Colors.green[900];

              print("isRegistered : " + isRegistered.toString());
              if (isRegistered != null) {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogIn(
                      message: isRegistered.message,
                      color: color,
                    ),
                  ),
                );
              } else {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogIn(
                      message: "Can not Register something went wrong",
                      color: color,
                    ),
                  ),
                );
              }
            },
          ),
        ));
  }

  User user = User();
  @override
  Widget build(BuildContext context) {
    final name = TextField(
      onChanged: (text) {
        user.name = text;
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final email = TextField(
      onChanged: (text) {
        user.email = text;
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final phone = TextField(
      onChanged: (text) {
        user.phone = text;
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Phone",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final aadhar = TextField(
      onChanged: (text) {
        print('submitted not called');
        print(text);
        user.aadhar = text;
        print(user.aadhar);
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "aadhar",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      onChanged: (text) {
        user.password = text;
      },
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final confirmPasswordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Confirm Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          //print(user.phone);
          //print(user.password);
          registerUser(user);
        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Color(0xff685EF2), fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Lets find together", style: kAppNameStyle),
      ),
      body: Center(
        child: Container(
          color: Color(0xFF6D60FB),
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: ListView(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'logo2.png',
                  ),
                ),
                SizedBox(height: 45.0),
                name,
                SizedBox(height: 25.0),
                email,
                SizedBox(
                  height: 15.0,
                ),
                phone,
                SizedBox(
                  height: 15.0,
                ),
                aadhar,
                SizedBox(
                  height: 15.0,
                ),
                passwordField,
                SizedBox(
                  height: 15.0,
                ),
                confirmPasswordField,
                SizedBox(
                  height: 15.0,
                ),
                registerButton,
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Already have account?",
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      child: Text(
                        "LogIn",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
