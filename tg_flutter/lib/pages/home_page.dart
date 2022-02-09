import 'package:flutter/material.dart';
import 'package:tg_flutter/pages/intro_page.dart';
import 'package:tg_flutter/pages/product_page.dart';
import 'package:tg_flutter/pages/user_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  List<Widget> _screen = [IntroPage(), UserPage(), ProductPage()];
  int _selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screen,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _selectedIndex == 0 ? Colors.orange : Colors.grey,
              ),
              title: Text(
                'Intro',
                style: TextStyle(
                  color: _selectedIndex == 0 ? Colors.orange : Colors.grey,
                ),
              )),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _selectedIndex == 1 ? Colors.orange : Colors.grey,
            ),
            title: Text('User',
                style: TextStyle(
                  color: _selectedIndex == 1 ? Colors.orange : Colors.grey,
                )),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: _selectedIndex == 2 ? Colors.orange : Colors.grey,
            ),
            title: Text('Product',
                style: TextStyle(
                  color: _selectedIndex == 2 ? Colors.orange : Colors.grey,
                )),
          ),
        ],
      ),
    );
  }
}
