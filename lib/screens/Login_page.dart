import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syscraftassign/screens/main_page_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  final bool isLoading = false;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  bool choose = false;

  String? _userEmail;
  String? _userName;

  String? _userPassword;

  void _trySubmit() async {
    final isvalid = _formKey.currentState!.validate();

    if (isvalid) {
      _formKey.currentState!.save(); //save everybvalue of formfield

      _userEmail!.trim();
      _userPassword!.trim();
      _userName!.trim();
      var pref = await SharedPreferences.getInstance();
      pref.setString('email', _userEmail!);
      pref.setString('password', _userPassword!);
      pref.setString('username', _userName!);

      // //   _isLogin,
      // //   context,
      // //   choose,

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext ctx) => MainPage()));

      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Card(
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // if (!_isLogin) UserImagePicker(_pickedImage),
                      if (!choose)
                        TextFormField(
                          key: ValueKey('email'),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@'))
                              return 'please enter correct email';
                            else
                              return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) {
                            _userEmail = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                          ),
                        ),
                      if (!_isLogin && !choose)
                        TextFormField(
                          key: ValueKey('username'),
                          onSaved: (value) {
                            _userName = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'please  enter ur name';
                            else
                              return null;
                          },
                          decoration: InputDecoration(labelText: 'Username'),
                        ),
                      if (!choose)
                        TextFormField(
                          key: ValueKey('pass'),
                          onSaved: (value) {
                            _userPassword = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty || value.length < 4)
                              return 'password is weak';
                            else
                              return null;
                          },
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                        ),
                      SizedBox(height: 12),
                      if (widget.isLoading) CircularProgressIndicator(),
                      if (!widget.isLoading)
                        Row(
                          children: [
                            if (!choose)
                              ElevatedButton(
                                child: Text(_isLogin ? 'login' : 'SignUp'),
                                onPressed: _trySubmit,
                                //we initialize method without parenthesis as we want to execute function on our behalf when button is pressed
                              ),
                          ],
                        ),
                      if (!widget.isLoading)
                        ElevatedButton(
                          child: Text(_isLogin
                              ? 'Create new account'
                              : 'I already have a account'),
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
