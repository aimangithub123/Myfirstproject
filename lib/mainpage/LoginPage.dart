
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:the_kidz/controller/authController.dart';
import 'RegisterPage.dart';

class LoginPage extends GetWidget<AuthController> {

  late String _email;
  late String _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _emailField() {
    return TextFormField(
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Email is required";
        }
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return "Please enter a valid email address";
        }
        return null;
      },
      onSaved: (String? value) {
        _email = value!;
      },
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Password is required";
        }
        return null;
      },
      onSaved: (String? value) {
        _password = value!;
      },
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Container(
              
              padding: EdgeInsets.all(36),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(image: AssetImage('assets/image/mylogo.gif')),
                    _emailField(),
                    SizedBox(
                      height: h / 30,
                    ),
                    _passwordField(),
                    SizedBox(
                      height: h / 30,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.yellow,
                      child: MaterialButton(
                        minWidth: w,
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            // return
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(content: Text("Invalid email or password")), NANTI BUAT!!!!!
                            //   );

                            return null;
                          }
                          _formKey.currentState!.save();
                          controller.SignIn(email: _email, password: _password);

                          print("SignIn pressed" + _email + _password);

                        },
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: h / 30,
                        ),
                        Center(
                            child: GestureDetector(
                                child: Text('New User? Create Account'),
                                onTap: () {

                                  Get.to(RegisterPage());
                                  // Navigator.pushReplacement<void, void>(
                                  //   context,
                                  //   MaterialPageRoute<void>(
                                  //     builder: (BuildContext context) => RegisterPage(),
                                  //   ),
                                  // );
                                }
                            ))
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
