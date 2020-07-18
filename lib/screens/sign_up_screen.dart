import 'package:flutter/material.dart';
import 'package:tikbot/data/local/user.dart';
import 'package:tikbot/data/local/user_storage.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameEditingController = TextEditingController();
  final _emailEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildNameTextInput() {
    return TextFormField(
      controller: _nameEditingController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(labelText: "Name", hintText: "Please provide your name", filled: true, fillColor: Colors.white),
      validator: (name) {
        if (name.trim().isEmpty) {
          return "Name must be provided ";
        } else
          return null;
      },
    );
  }

  Widget _buildEmailTextInput() {
    return TextFormField(
      controller: _emailEditingController,
      keyboardType: TextInputType.emailAddress,
      decoration:
          InputDecoration(labelText: "Email Address", hintText: "Please provide your Email Address", filled: true, fillColor: Colors.white),
      validator: (email) {
        if (email.trim().isEmpty) {
          return "Email must be provided ";
        } else if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(email)) {
          return "This is not a valid email Address";
        } else
          return null;
      },
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 50.0,
      child: RaisedButton(
        color: Colors.redAccent,
        elevation: 8.0,
        onPressed: () => _saveUserToHiveDb(),
        child: Text('Proceed to chat room', style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600)),
      ),
    );
  }

  _saveUserToHiveDb() async {
    if (_formKey.currentState.validate()) {
      final name = _nameEditingController.text.toString();
      final email = _emailEditingController.text.toString();
      print("username is $name and email is $email");
      final userStorage = await UserStorage.getInstance();
      userStorage.addUser(User(name: name, email: email));
      Navigator.pushReplacementNamed(context, "chat");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF252231),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 20.0),
                _buildNameTextInput(),
                SizedBox(height: 20.0),
                _buildEmailTextInput(),
                SizedBox(height: 20.0),
                _buildSubmitButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
