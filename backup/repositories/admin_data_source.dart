import '../mvvm/models/user.dart';
import '../mvvm/models/pageable_permissions.dart';
import '../mvvm/models/pageable_roles.dart';
import '../mvvm/models/pageable_users.dart';
import '../mvvm/models/session.dart';

abstract class AdminDataSource {
  Future<Session> signIn(String email, String password);
  Future<Session> refreshToken(String token);
  Future<void> signOut(String token);
  Future<UserModel> signUp(
      String email, String password, String firstName, String lastName);

  Future<PageableUsersModel> getUsers();
  Future<PagableRolesModel> getRoles();
  Future<PagablePermissionsModel> getPermissions();
}
