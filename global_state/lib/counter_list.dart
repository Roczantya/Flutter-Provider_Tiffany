import 'package:flutter/material.dart';
import 'global_state_lib/globalstate.dart';
import 'package:provider/provider.dart';

class CounterList extends StatelessWidget {
  const CounterList({super.key});

  @override
  Widget build(BuildContext context) {
    final globalState = context.watch<GlobalState>();
    final counters = globalState.counters;

    return Scaffold(
      appBar: AppBar(title: const Text('Global State Counter App')),
      body: ReorderableListView.builder(
        itemCount: counters.length,
        onReorder: globalState.reorderCounters,
        itemBuilder: (context, index) {
          final counter = counters[index];
          return Card(
            key: ValueKey(counter),
            color: counter.color,
            child: ListTile(
              title: Text(counter.label),
              subtitle: Text('Value: ${counter.value}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        Icons.add,
                        key: ValueKey(counter.value), // Key unik untuk animasi
                      ),
                    ),
                    onPressed: () => globalState.incrementCounter(index),
                  ),
                  IconButton(
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        Icons.remove,
                        key: ValueKey(counter.value), // Key unik untuk animasi
                      ),
                    ),
                    onPressed: () => globalState.decrementCounter(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => globalState.removeCounter(index),
                  ),
                ],
              ),
              onTap: () => _showEditDialog(context, index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: globalState.addCounter,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditDialog(BuildContext context, int index) {
    final globalState = context.read<GlobalState>();
    final counter = globalState.counters[index];
    final TextEditingController labelController =
        TextEditingController(text: counter.label);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Counter'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: labelController,
              decoration: const InputDecoration(labelText: 'Label'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: Colors.primaries.map((color) {
                return GestureDetector(
                  onTap: () {
                    globalState.updateCounterColor(index, color);
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(backgroundColor: color),
                );
              }).toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              globalState.updateCounterLabel(index, labelController.text);
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
