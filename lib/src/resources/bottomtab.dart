import 'package:book_car_app/src/resources/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  var _showpage;
  final HomePage _homePage = new HomePage();
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  Widget _pageChoose(int page) {
    switch (page) {
      case 0:
        return _homePage;

      case 1:
        return _homePage;

      case 2:
        return _homePage;

      case 3:
        return _homePage;

      default:
        return Container(
          child: Text('hello'),
        );
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _showpage = _homePage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: const <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
            Icon(Icons.call_split, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 400),
          onTap: (index) {
            setState(() {
              _showpage = _pageChoose(index);
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: _showpage,
          ),
        ));
  }
}
