import 'package:riverpod_tutorial/domain/user_entity.dart';

abstract class UserRepository {
  Future<List<UserEntity>> getUsers();
}
