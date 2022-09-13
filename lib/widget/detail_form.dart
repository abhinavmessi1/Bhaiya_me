import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  bool choose = false;

  String? _userName;
  String? _DateOfBirth;

  void _trySubmit() {
    final isvalid = _formKey.currentState!.validate();

    if (isvalid) {
      _formKey.currentState!.save(); //save everybvalue of formfield

//FocusScope.of(context).unfocus();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
                  // TextFormField(

                  // ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    // textColor: Theme.of(context).primaryColor,
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
    );
  }
}
