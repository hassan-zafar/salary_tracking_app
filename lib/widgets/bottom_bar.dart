import 'package:flutter/material.dart';
import 'package:salary_tracking_app/consts/collections.dart';
import 'package:salary_tracking_app/consts/my_icons.dart';
import 'package:salary_tracking_app/provider/dark_theme_provider.dart';
import 'package:salary_tracking_app/screens/adminScreens/allUsers.dart';
import 'package:salary_tracking_app/screens/adminScreens/chatLists.dart';
import 'package:salary_tracking_app/screens/adminScreens/uploadVideo.dart';
import 'package:salary_tracking_app/screens/employe_page.dart';
import 'package:salary_tracking_app/screens/home_page.dart';
import 'package:salary_tracking_app/screens/user_info.dart';
import 'package:provider/provider.dart';

import '../consts/colors.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  // List<Map<String, Object>> _pages;
  ScrollController? _scrollController;
  var top = 0.0;

  @override
  void initState() {
    pages = [
      const EmployeePage(),
      const UserInfoScreen(),
      HomePage(),
      UserNSearch(),
      ChatLists(),
    ];

    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      setState(() {});
    });
    // getData();
  }

  int _selectedPageIndex = 0;
  late List pages;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Container( decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorsConsts.gradiendFStart,
              Colors.orange,
              ColorsConsts.gradiendFEnd,
            ],
          ),
        ),
      child: Scaffold(
        body: pages[_selectedPageIndex], //_pages[_selectedPageIndex]['page'],
        bottomNavigationBar: BottomAppBar(
          // color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 0.01,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: kBottomNavigationBarHeight * 0.98,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
              ),
              child: BottomNavigationBar(
                onTap: _selectPage,
                backgroundColor: Theme.of(context).primaryColor,
                unselectedItemColor: Colors.white,
                selectedItemColor: const Color(0xff805130),
                currentIndex: _selectedPageIndex,
                // selectedLabelStyle: TextStyle(fontSize: 16),
                items: 
                currentUser!=null&& currentUser!.isAdmin!
                    ? [
                        const BottomNavigationBarItem(
                            icon: Icon(
                              Icons.home,
                            ),
                            label: 'Home Page'),
                        const BottomNavigationBarItem(
                            icon: Icon(
                              Icons.home,
                            ),
                            label: 'Log Page'),
                        const BottomNavigationBarItem(
                            icon: Icon(
                              Icons.people,
                            ),
                            label: 'All Users'),
                        BottomNavigationBarItem(
                            icon: Icon(
                              MyAppIcons.user,
                            ),
                            label: 'My Profile'),
                        const BottomNavigationBarItem(
                            icon: Icon(
                              Icons.chat_bubble,
                            ),
                            label: 'Admin Chats'),
                      ]
                    :
                     [
                        const BottomNavigationBarItem(
                            icon: Icon(
                              Icons.home,
                            ),
                            label: 'Home Page'),
                        BottomNavigationBarItem(
                            icon: Icon(
                              MyAppIcons.user,
                            ),
                            label: 'My Profile'),
                      ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
