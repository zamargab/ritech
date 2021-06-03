import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ritech/Config/colors.dart';
import 'package:ritech/Config/config.dart';
import 'package:ritech/widgets/customTextFields.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  final TextEditingController _cPasswordTextEditingController =
      TextEditingController();

  final TextEditingController _phoneNumberTextEditingController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userImageUrl = "";
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Image.asset(
                      "assets/images/rlogo.png",
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Ritech",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Muli",
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF05242C),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Welcome to Ritech, Create an account and gain access to our platform",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Muli",
                        color: Color(0xFF4F4F4F),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFieldNew(
                          controller: _nameTextEditingController,
                          data: Icons.person,
                          hintText: "Name",
                          isObsecure: false,
                        ),
                        CustomTextFieldNew(
                          controller: _phoneNumberTextEditingController,
                          data: Icons.email,
                          hintText: "Phone Number",
                          isObsecure: false,
                        ),
                      ],
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    color: kHomeColor,
                    child: Text(
                      "Save Details",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 4.0,
                    width: _screenWidth * 0.8,
                    color: kHomeColor,
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
