library global_state_lib;

import 'package:flutter/material.dart';

/// Model for a single counter
class CounterModel {
  int value;
  Color color;
  String label;

  CounterModel({
    required this.value,
    required this.color,
    required this.label,
  });
}

/// Global state management for counters
class GlobalState extends ChangeNotifier {
  final List<CounterModel> _counters = [];

  List<CounterModel> get counters => _counters;

  void addCounter() {
    _counters.add(
      CounterModel(
        value: 0,
        color: Colors.primaries[_counters.length % Colors.primaries.length],
        label: 'Counter ${_counters.length + 1}',
      ),
    );
    notifyListeners();
  }

  void removeCounter(int index) {
    if (index >= 0 && index < _counters.length) {
      _counters.removeAt(index);
      notifyListeners();
    }
  }

  void incrementCounter(int index) {
    if (index >= 0 && index < _counters.length) {
      _counters[index].value++;
      notifyListeners();
    }
  }

  void decrementCounter(int index) {
    if (index >= 0 && index < _counters.length && _counters[index].value > 0) {
      _counters[index].value--;
      notifyListeners();
    }
  }

  void updateCounterColor(int index, Color color) {
    if (index >= 0 && index < _counters.length) {
      _counters[index].color = color;
      notifyListeners();
    }
  }

  void updateCounterLabel(int index, String label) {
    if (index >= 0 && index < _counters.length) {
      _counters[index].label = label;
      notifyListeners();
    }
  }

  void reorderCounters(int oldIndex, int newIndex) {
    if (oldIndex != newIndex) {
      final counter = _counters.removeAt(oldIndex);
      _counters.insert(newIndex, counter);
      notifyListeners();
    }
  }
}
