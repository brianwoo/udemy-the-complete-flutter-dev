import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late double _deviceHeight, _deviceWidth;
  final _registerFormKey = GlobalKey<FormState>();
  late FirebaseService _firebaseService;

  late String? _userName;
  late String? _email;
  late String? _password;
  File? _imageFile;

  @override
  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _titleWidget(),
                _registrationForm(),
                _registerButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileImage() {
    var imageProvider = _imageFile != null
        ? FileImage(_imageFile!)
        : NetworkImage("https://i.pravatar.cc/300");
    return GestureDetector(
      onTap: () async {
        FilePicker.platform.pickFiles(type: FileType.image).then((value) {
          setState(() {
            _imageFile = File(value!.files.first.path!);
          });
        });
      },
      child: Container(
        height: _deviceHeight * 0.25,
        width: _deviceWidth * 0.25,
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: imageProvider as ImageProvider,
        )),
      ),
    );
  }

  Widget _registrationForm() {
    return Form(
        key: _registerFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _profileImage(),
            _userNameTextField(),
            SizedBox(height: 20),
            _emailTextField(),
            SizedBox(height: 20),
            _passwordTextField(),
          ],
        ));
  }

  Widget _userNameTextField() {
    return TextFormField(
      validator: (value) => value!.isNotEmpty ? null : 'Please enter a name',
      decoration: const InputDecoration(labelText: "User name"),
      onSaved: (newValue) {
        _userName = newValue;
      },
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter a valid email";
        }

        final result = value.contains(RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"));

        return result ? null : "Please enter a valid email";
      },
      decoration: const InputDecoration(labelText: "Email"),
      onSaved: (newValue) {
        _email = newValue;
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      validator: (value) => value!.length > 6
          ? null
          : 'Password needs to be at least 7 digit long',
      decoration: const InputDecoration(labelText: "Password"),
      obscureText: true,
      onSaved: (newValue) {
        _password = newValue;
      },
    );
  }

  Widget _titleWidget() {
    return Text(
      "Finstagram",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _registerButton() {
    return MaterialButton(
      onPressed: () {
        register();
      },
      minWidth: _deviceWidth * 0.70,
      height: _deviceHeight * 0.06,
      color: Colors.red,
      child: const Text(
        'Register',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void register() async {
    if (_registerFormKey.currentState!.validate()) {
      _registerFormKey.currentState!.save();
      print(_email);
      print(_userName);
      print(_password);
      print(_imageFile);
      if (_userName != null &&
          _email != null &&
          _password != null &&
          _imageFile != null) {
        final result = await _firebaseService.registerUser(
          name: _userName!,
          email: _email!,
          password: _password!,
          image: _imageFile!,
        );
        if (result) {
          Navigator.pop(context);
        }
      }
    }
  }
}
