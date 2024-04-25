import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/counter.dart';
import 'package:riverpod_tutorial/data/user_data_source.dart';
import 'package:riverpod_tutorial/data/user_repo_impl.dart';
import 'package:riverpod_tutorial/domain/user_entity.dart';
import 'package:riverpod_tutorial/domain/user_repo.dart';
import 'package:riverpod_tutorial/domain/user_use_case.dart';

final nameProvider = StateProvider<String>(
  (ref) {
    return 'Neeraj';
  },
);

final countProvider = StateNotifierProvider<Counter, int>((ref) => Counter());

final userDataSourceProvider = Provider<UserDataSource>(
  (ref) {
    return UserDataSource();
  },
);
final userRepositoryProvider = Provider<UserRepository>(
  (ref) {
    return UserRepositoryImplementation(
      ref.read(userDataSourceProvider),
    );
  },
);

final userUserCaseProvider = Provider<UserUseCase>(
  (ref) {
    return UserUseCase(
      userRepository: ref.read(userRepositoryProvider),
    );
  },
);

final userDataProvider = FutureProvider<List<UserEntity>>((ref) {
  return ref.read(userUserCaseProvider).getUsers();
});

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(nameProvider);
    final count = ref.watch(countProvider);
    final userData = ref.watch(userDataProvider);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
              ],
            ),
            const SizedBox(height: 20),
            userData.when(
              data: (data) {
                return SizedBox(
                  height: 600,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final user = data[index];
                      return ListTile(
                        title: Text(user.name),
                        subtitle: Text(user.email),
                      );
                    },
                  ),
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
