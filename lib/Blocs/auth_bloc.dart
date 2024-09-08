import 'package:chat_app/Blocs/auth_event.dart';
import 'package:chat_app/Blocs/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async{
      if(event is LoginEvent) {
        emit(LoginLoading());
        try {
          UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: event.userEmail, password: event.userPassword);
          emit(LoginSuccess());

        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailure(errMessage: 'No user found for that email'));
          }
          else if (e.code == 'wrong-password') {
            emit(LoginFailure(errMessage: 'Wrong password'));
          }
        } catch (e) {
          emit(LoginFailure(errMessage: 'there was an error'));
        }
      }
      else if(event is RegisterEvent){
        emit(RegisterLoading());
        try {
          UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: event.userEmail, password: event.userPassword);
          emit(RegisterSuccess());

        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(RegisterFailure(errMessage: 'password provided is too weak'));
          }
          else if (e.code == 'email-already-in-use') {
            emit(RegisterFailure(errMessage: 'email already exists'));
          }
        } catch (e) {
          emit(RegisterFailure(errMessage: 'there was an error'));
        }
      }
    });
  }
}
