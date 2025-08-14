part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

// --------------------- Check User is Logged In or Not --------------- //
final class CheckAuthStatusLoading extends AuthState {}

final class CheckAuthStatusLoaded extends AuthState {}

final class CheckAuthStatusFailed extends AuthState {}

//---------------- Login with Email -------------------//
final class LoginLoading extends AuthState {}

final class LoginLoaded extends AuthState {
  final LoginResponse loginResponse;

  const LoginLoaded({required this.loginResponse});

  @override
  List<Object> get props => [loginResponse];
}

final class LoginFailed extends AuthState {
  final String error;

  const LoginFailed({required this.error});

  @override
  List<Object> get props => [error];
}
