import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class GoogleLoadingState extends AuthState {}

class GoogleSuccessState extends AuthState {
  final UserCredential user;

  GoogleSuccessState(this.user);
}

class GoogleFailedState extends AuthState {
  final String error;

  GoogleFailedState(this.error);
}
