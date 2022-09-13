import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syscraftassign/screens/Login_page.dart';
import 'package:syscraftassign/widget/detail_form.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void _logoutfun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext ctx) => LoginPage()));
  }

  void _startAddNewDetails(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: DetailScreen(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: _logoutfun, icon: Icon(Icons.logout))],
      ),
      body: Container(
        width: double.infinity,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewDetails(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
