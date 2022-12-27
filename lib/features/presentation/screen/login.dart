import 'package:chat_app/config/app_rooutes.dart';
import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/core/app_strings.dart';
import 'package:chat_app/core/media_query.dart';
import 'package:chat_app/features/presentation/cubit/login/login_cubit.dart';
import 'package:chat_app/features/presentation/cubit/login/login_cubit_state.dart';
import 'package:chat_app/features/presentation/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../provider/obsecure_provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String? _email, _password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ObsecureProvider provider = Provider.of<ObsecureProvider>(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.of(context).pushNamed(Routes.chatPage, arguments: _email!);
          isLoading = false;
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("SomeThing went Wrong")));
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.primary,
            body: Form(
              key: _globalKey,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Image(
                            image: AssetImage('assets/images/chat.png'),
                          ),
                          Positioned(
                            bottom: 5.0,
                            child: Text(
                              AppStrings.appName,
                              style: GoogleFonts.pacifico(fontSize: 25.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.height * .1,
                  ),
                  MyTextField(
                    onClick: (value) {
                      _email = value;
                    },
                    hint: 'Enter your e-mail',
                    icon: Icons.email,
                    obsecured: false,
                  ),
                  SizedBox(
                    height: context.height * .04,
                  ),
                  MyTextField(
                    onClick: (value) {
                      _password = value;
                    },
                    hint: 'Enter your password',
                    icon: Icons.lock,
                    obsecured: provider.obsecure,
                    suffixIcon: provider.obsecure == true
                        ? IconButton(
                            onPressed: () => provider.changeObsecure(false),
                            icon: const Icon(Icons.visibility))
                        : IconButton(
                            onPressed: () => provider.changeObsecure(true),
                            icon: const Icon(Icons.visibility_off),
                          ),
                  ),
                  SizedBox(
                    height: context.height * .02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .27),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                      onPressed: () async {
                        if (_globalKey.currentState!.validate()) {
                          _globalKey.currentState!.save();
                          BlocProvider.of<LoginCubit>(context, listen: false)
                              .signIn(email: _email!, password: _password!);
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  SizedBox(
                    height: context.height * .05,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have account ? ",
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                      GestureDetector(
                        child: const Text(
                          "SignUp",
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.signUpScreen);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
