import 'package:flutter/material.dart';
import 'package:lost_and_found/constants/logo.dart';
import 'constants/constants.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lets find together", style: kAppNameStyle),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/login');
        },
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 9,
                    child: Container(
                      child: Center(
                        child: Logo(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Text("Angel@CO", style: kCompanyNameStyle),
                          Text(
                            "LOST AND FOUND",
                            style: kAppNameStyle,
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
      ),
    );
  }
}
