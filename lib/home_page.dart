import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/counter.dart';

final nameProvider = StateProvider<String>(
  (ref) {
    return 'Neeraj';
  },
);

final countProvider = StateNotifierProvider<Counter, int>((ref) => Counter());

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(nameProvider);
    final count = ref.watch(countProvider);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Hello $name'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(nameProvider.notifier).state = 'Aditya';
              },
              child: const Text('Change Name'),
            ),
            const SizedBox(height: 20),
            Text('Current count is $count'),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              ElevatedButton(
                onPressed: () {
                  ref.read(countProvider.notifier).decrement();
                },
                child: const Text('-'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(countProvider.notifier).increment();
                },
                child: const Text('+'),
              ),
            ],)
          ],
        ),
      ),
    );
  }
}
