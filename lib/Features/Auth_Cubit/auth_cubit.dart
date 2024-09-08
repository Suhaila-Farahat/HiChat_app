import 'package:chat_app/Features/Auth_Cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);


  Future<void> loginUser({required String userEmail, required String userPassword}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: userEmail, password: userPassword);
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


  Future<void> registerUser({required String userEmail, required String userPassword}) async {
    emit(RegisterLoading());
    try {
      UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userEmail, password: userPassword);
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


}
