import '../entities/app_user.dart';

abstract class AppUserRepo {
  Future<AppUser?> login(String email, String password);
  Future<AppUser?> signUp(String name, String email, String password);
  Future<void> logOut();
  Future<AppUser?> getCurrentUser();
}
