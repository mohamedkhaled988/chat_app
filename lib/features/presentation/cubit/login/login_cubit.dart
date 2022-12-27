import 'package:chat_app/features/presentation/cubit/login/login_cubit_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final _auth = FirebaseAuth.instance;

  Future<void> signIn({required String email, required String password}) async {
    emit(LoginLoading()) ;
    try{
     await _auth.signInWithEmailAndPassword(
          email: email, password: password);
     emit(LoginSuccess()) ;
    }on Exception catch (e) {
        emit(LoginFailure()) ;
    }
  }
}
