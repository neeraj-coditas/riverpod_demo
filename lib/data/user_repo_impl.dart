import 'package:riverpod_tutorial/data/user_data_source.dart';
import 'package:riverpod_tutorial/domain/user_entity.dart';
import 'package:riverpod_tutorial/domain/user_repo.dart';

class UserRepositoryImplementation extends UserRepository {
  UserRepositoryImplementation(this.userDataSource);

  UserDataSource userDataSource;

  @override
  Future<List<UserEntity>> getUsers() {
    return userDataSource.getUsers();
  }
}
