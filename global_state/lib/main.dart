import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'global_state_lib/globalstate.dart';
import 'counter_list.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => GlobalState(),
        child: const CounterList(),
      ),
    );
  }
}
