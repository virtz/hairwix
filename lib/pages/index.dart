import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hairmarket/pages/tab_screens/cart.dart';
import 'package:hairmarket/pages/tab_screens/chat.dart';

import 'package:hairmarket/pages/tab_screens/home.dart';
import 'package:hairmarket/pages/tab_screens/profile.dart';


class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int cindex = 0;

  final List<Widget> _children = [Home(),Cart(),Chat(),Profile()];
  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.init(context,
        width: defaultScreenWidth,
        height: defaultScreenHeight,
        allowFontScaling: true);
    // var size = MediaQuery.of(context).size;


    return Scaffold(
      body: _children[cindex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left:8.0,right:8.0,),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.home, color: Colors.green),
                icon: Icon(Icons.home, color: Colors.grey),
                label:''),
                 
                       BottomNavigationBarItem(
                activeIcon: Icon(Icons.shopping_cart, color: Colors.green),
                icon: Icon(Icons.shopping_cart, color: Colors.grey),
                label:''),
                       BottomNavigationBarItem(
                activeIcon: Icon(Icons.chat, color: Colors.green),
                icon: Icon(Icons.chat, color: Colors.grey),
                label:''),
                       BottomNavigationBarItem(
                activeIcon: Icon(Icons.person, color: Colors.green),
                icon: Icon(Icons.person, color: Colors.grey),
                label:''),
                
          ],
            currentIndex: cindex,
            onTap: (int i) {
              setState(() {
                cindex = i;
              });
            },
            
        ),
      ),
    );
  }

  // Widget buildCard() {}
}
