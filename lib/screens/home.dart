import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobcom/constants.dart';
import 'package:mobcom/widgets/bottom_tabs.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController?  _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }
  @override
  void dispose() {
    _tabsPageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Expanded(
            child: PageView(
              controller: _tabsPageController,
              onPageChanged: (num){
                setState(() {
                  _selectedTab = num;
                });
              },
              children: [
                Container(
                  child: Center(
                    child: Text("Home Page"),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text("Search Page"),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text("saved Page"),
                  ),
                ),
              ],
            ),
           ),
          BottomTabs(
            selectedTab: _selectedTab,
            tabPressed: (num){
                 _tabsPageController!.animateToPage(
                     num,
                     duration: Duration(milliseconds: 300),
                     curve: Curves.easeOutCubic
                 );
            },
          ),
         ],
       ),
    );
  }
}
