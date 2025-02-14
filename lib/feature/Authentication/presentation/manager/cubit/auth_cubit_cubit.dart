import 'package:bloc/bloc.dart';
import 'package:flutter_weather_ai/feature/Authentication/domain/entities/app_user.dart';
import 'package:flutter_weather_ai/feature/Authentication/domain/repo/app_user_repo.dart';
import 'package:meta/meta.dart';

part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit({required this.appUserRepo}) : super(AuthCubitInitial());
  AppUserRepo appUserRepo;
  // ignore: unused_field
  AppUser? _appUser;
  void checkAuth() async {
    final AppUser? user = await appUserRepo.getCurrentUser();
    if (user != null) {
      _appUser = user;
      emit(AuthCubitSuccess(user: user));
    } else {
      emit(UnAuthCubit());
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      emit(AuthCubitLoading());
      final user = await appUserRepo.login(email, password);
      if (user != null) {
        _appUser = user;
        emit(AuthCubitSuccess(user: user));
      } else {
        emit(UnAuthCubit());
      }
    } catch (e) {
      emit(AuthCubitFail(errmessage: e.toString()));
      emit(UnAuthCubit());
    }
  }

  Future<void> register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      emit(AuthCubitLoading());
      final user = await appUserRepo.signUp(name, email, password);
      if (user != null) {
        _appUser = user;
        emit(AuthCubitLoading());
      } else {
        emit(UnAuthCubit());
      }
    } catch (e) {
      emit(AuthCubitFail(errmessage: e.toString()));
      emit(UnAuthCubit());
    }
  }

  Future<void> logout() async {
    appUserRepo.logOut();
    emit(UnAuthCubit());
  }
}
