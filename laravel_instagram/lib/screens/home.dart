import 'package:flutter/material.dart';
import 'package:laravel_instagram/screens/login.dart';
import 'package:laravel_instagram/screens/post_form.dart';
import 'package:laravel_instagram/screens/post_screen.dart';
import 'package:laravel_instagram/screens/profile.dart';
import 'package:laravel_instagram/services/user_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog App'),
        actions: [
          IconButton(
              onPressed: () {
                logout().then((value) => Navigator.of(context)
                    .pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Login()),
                        (route) => false));
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: currentIndex == 0 ?PostScreen():Profile(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PostForm(
            title: 'Add New Post',
          )));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label:'' 
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: ''
            )],
            currentIndex: currentIndex,
            onTap: (val){
              setState(() {
                currentIndex=val;
              });
            },
        ),
      ),
    );
  }
}
