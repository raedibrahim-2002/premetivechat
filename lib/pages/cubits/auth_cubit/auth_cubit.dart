import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    try {
      emit(LoginLoading());
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == "user-not-found") {
        emit(LoginFailure(errmessage: "user_not_found"));
      } else if (ex.code == "wrong-password"){
        emit(LoginFailure(errmessage: "password"));
      }
    } catch (e) {
      emit(LoginFailure(errmessage: "something went wronge"));
    }
  }



    Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());

    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
      print("success register");
    } 
    on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(RegisterFailure(errMessage: 'weak-password'));
      } else if (ex.code == 'email-already-in-use') {
        emit(RegisterFailure(errMessage: "email-already-in-use"));
      }
    } catch (e) {
      emit(RegisterFailure(errMessage: "something went wrong"));
    }
  }
}
