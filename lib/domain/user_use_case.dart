import 'package:riverpod_tutorial/domain/user_entity.dart';
import 'package:riverpod_tutorial/domain/user_repo.dart';

class UserUseCase {
  UserUseCase({required this.userRepository});

  UserRepository userRepository;

  Future<List<UserEntity>> getUsers() {
    return userRepository.getUsers();
  }
}
