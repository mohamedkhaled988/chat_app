
import 'package:chat_app/features/presentation/cubit/register/register_cubit_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit <RegisterState> {
  RegisterCubit () :super(RegisterInitial()) ;
  final _auth = FirebaseAuth.instance;

  Future<void> signUp(String email, String password) async {
    emit(RegisterLoading()) ;
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      emit(RegisterSuccess()) ;
    } on Exception catch (e) {
      emit(RegisterFailure()) ;
    }

  }

}