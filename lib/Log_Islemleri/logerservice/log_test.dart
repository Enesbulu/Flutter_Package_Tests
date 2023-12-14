import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Log Kaydı')),
        body: LogKaydi(),
      ),
    );
  }
}

class LogKaydi extends StatefulWidget {
  @override
  _LogKaydiState createState() => _LogKaydiState();
}

class _LogKaydiState extends State<LogKaydi> {
  final Logger _logger = Logger();
  // late Output _output = ConsoleOutput();
  // final _output = output();

  void _addLogEntry(String entry) {
    _logger.d(entry);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () => _addLogEntry('Button clicked'),
          child: const Text('Log Kaydı Oluştur'),
        ),
        SingleChildScrollView(
          child: Column(
              // children: _logger.logs.map((e) => Text(e.message)).toList(),
              // children: _output.buffer.map((e) => Text(e.message)).toList(),
              ),
        ),
      ],
    );
  }
}
