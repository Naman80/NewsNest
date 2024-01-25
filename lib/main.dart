import 'package:flutter/material.dart';
import 'package:newsnest/Models/news.model.dart';
import 'package:newsnest/backend/api/newsapi.dart';

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
            seedColor: Colors.yellow, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      // colorScheme:
      // ColorScheme.fromSwatch().copyWith(brightness: Brightness.dark)),
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
  List<NewsModel> allNewsList = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  void fetchNews() async {
    final newsList = await NewsApi.fetchNewsList();
    setState(() {
      allNewsList = newsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build is called");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const Text("data"),
            Expanded(
                child: ListView.builder(
              itemCount: allNewsList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(allNewsList[index].content),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
