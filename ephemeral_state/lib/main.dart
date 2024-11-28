import 'package:flutter/material.dart';

void main() {
  runApp(const MyEphemeralApp());
}

class MyEphemeralApp extends StatelessWidget {
  const MyEphemeralApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Ephemeral State Example')),
        body: CounterWidget(),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0; // Status lokal untuk menghitung nilai

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      if (_counter > 0) _counter--; // Mencegah nilai turun di bawah nol
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Counter Value: $_counter',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _increment,
                child: const Text('Tambah'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _decrement,
                child: const Text('Kurangi'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
