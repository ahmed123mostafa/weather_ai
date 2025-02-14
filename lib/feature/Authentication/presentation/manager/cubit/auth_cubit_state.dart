part of 'auth_cubit_cubit.dart';

@immutable
sealed class AuthCubitState {}

final class AuthCubitInitial extends AuthCubitState {}

final class AuthCubitLoading extends AuthCubitState {}

final class UnAuthCubit extends AuthCubitState {}

final class AuthCubitSuccess extends AuthCubitState {
  final AppUser user;

  AuthCubitSuccess({required this.user});
}

final class AuthCubitFail extends AuthCubitState {
  final String errmessage;

  AuthCubitFail({required this.errmessage});
}
