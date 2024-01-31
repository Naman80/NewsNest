import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:newsnest/Utils/providers/bookmarks_provider.dart';
import 'package:newsnest/Utils/providers/newslist_provider.dart';
import 'package:newsnest/constants/colors.dart';
import 'package:newsnest/screens/bookmark_screen.dart';
import 'package:newsnest/screens/explore_screen.dart';
import 'package:newsnest/screens/home_screen.dart';
import 'package:newsnest/screens/profile_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => NewsListProvider()),
    ChangeNotifierProvider(create: (_) => BookmarkListProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NewsNest',
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
  int _selectedIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    ExploreScreen(),
    const BookmarkScreen(),
    const ProfileScreen()
  ];

  @override
  void initState() {
    context.read<BookmarkListProvider>().init();
    context.read<NewsListProvider>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: BgColorPicker.primary,
          body: Center(child: screens[_selectedIndex]),
          bottomNavigationBar: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 80.0,
              child: Container(
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
                  )))),
    );
  }
}
