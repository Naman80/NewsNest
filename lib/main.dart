import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          centerTitle: true,
        ),
        body: const Column(
          children: [
            Text("data"),
            ElevatedButton(
                onPressed: apiCall, child: Text("Press me to call api"))
          ],
        ),
      ),
    );
  }
}

void apiCall() async {
  String apiKey = "7f2fde8120d949e593762165e25e4300";
  String url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=$apiKey";
  final apiResponse = await http.get(Uri.parse(url));
  print(apiResponse.body);
}
