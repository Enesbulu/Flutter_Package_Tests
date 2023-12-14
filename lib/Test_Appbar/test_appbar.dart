import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          appBar: CustomAppBar(), //YourAppBar(title: "TEst"),
          body: const SeconPageBody() //const Center(
          //   child: Text('Hello World'),
          // ),
          ),
    );
  }
}

class MyAppBarTest extends AppBar {
  final String text;
  MyAppBarTest({super.key, required this.text});
  @override
  Size get preferredSize => super.preferredSize;
}

class SeconPageBody extends StatelessWidget {
  const SeconPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        children: [
          ElevatedButton(onPressed: () {}, child: Text("Gerçekleştir")),
          Text("Secon Page Body"),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;

  CustomAppBar({this.title = "Custom App Bar", this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.green,
      leading: IconButton(
        onPressed: () {
          print("back oku çalışıuyor");
        },
        icon: const Icon(Icons.arrow_back),
      ),
      
    );
  }
}
