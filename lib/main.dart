import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:newsnest/Models/news.model.dart';
import 'package:newsnest/backend/api/newsapi.dart';
import 'package:newsnest/constants/colors.dart';
import 'package:newsnest/screens/bookmark_screen.dart';
import 'package:newsnest/screens/explore_screen.dart';
import 'package:newsnest/screens/home_screen.dart';
import 'package:newsnest/screens/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purple, brightness: Brightness.dark),
        useMaterial3: true,
        // colorScheme:
        // ColorScheme.fromSwatch().copyWith(brightness: Brightness.dark),
        //
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> screens = [];
  int _selectedIndex = 0;
  late ScrollController _hideButtonController;
  bool _isVisible = true;
  @override
  void initState() {
    print("home init state is called");
    super.initState();
    fetchNews();
    _isVisible = true;
    _hideButtonController = ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      }
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      }
    });
  }

  void fetchNews() async {
    print("home fetch news is called");
    final newsList = await NewsApi.fetchTopHeadlines();
    setState(() {});
    screens = [
      HomeScreen(newsList: newsList, _hideButtonController),
      ExploreScreen(newsList: newsList, _hideButtonController),
      const BookmarkScreen(),
      const ProfileScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: BgColorPicker.primary,
          body: Center(child: screens[_selectedIndex]),
          bottomNavigationBar: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _isVisible ? 80.0 : 0.0,
            child: _isVisible
                ? Container(
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: BgColorPicker.secondary.withOpacity(0.9),
                        border: Border(
                            top: BorderSide(
                          width: 1,
                          color: Colors.grey.withAlpha(10),
                        ))),
                    padding: const EdgeInsets.all(16),
                    child: GNav(
                      tabBorderRadius: 17,
                      // backgroundColor: Colors.red,
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: BgColorPicker.secondary,
                          fontSize: 16),
                      gap: 3,
                      haptic: true,
                      duration: const Duration(milliseconds: 500),
                      color: IconColorPicker.primary,
                      activeColor: IconColorPicker.secondary,
                      tabBackgroundColor: BgColorPicker.selectedNav,
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 19),
                      iconSize: 24,
                      tabMargin: const EdgeInsets.all(0),
                      tabs: [
                        GButton(
                          icon: _selectedIndex == 0
                              ? Icons.home
                              : Icons.home_outlined,
                          text: "Home",
                        ),
                        GButton(
                          icon: _selectedIndex == 1
                              ? Icons.explore
                              : Icons.explore_outlined,
                          text: "Explore",
                        ),
                        GButton(
                          icon: _selectedIndex == 2
                              ? Icons.bookmark_add_rounded
                              : Icons.bookmark_add_outlined,
                          text: "Bookmarks",
                        ),
                        GButton(
                          icon: _selectedIndex == 3
                              ? Icons.person_2
                              : Icons.person_2_outlined,
                          text: "Profile",
                        )
                      ],
                      selectedIndex: _selectedIndex,
                      onTabChange: (value) =>
                          {setState(() => _selectedIndex = value)},
                    ))
                : Container(),
          )),
    );
  }
}
