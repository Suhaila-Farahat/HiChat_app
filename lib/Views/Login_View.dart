import 'package:chat_app/Blocs/auth_bloc.dart';
import 'package:chat_app/Blocs/auth_event.dart';
import 'package:chat_app/Blocs/auth_state.dart';
import 'package:chat_app/Components/Custom_Button.dart';
import 'package:chat_app/Components/Custom_Snack_Bar.dart';
import 'package:chat_app/Components/Custom_Text_Field.dart';
import 'package:chat_app/Constants.dart';
import 'package:chat_app/Features/Chat_Cubit/chat_cubit.dart';
import 'package:chat_app/Views/Chat_View.dart';
import 'package:chat_app/Views/Sign_View.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class LoginView extends StatelessWidget {

  static String id = 'Login View';

  String? userEmail;
  String? userPassword;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading){
          isLoading =true;
        }
        else if (state is LoginSuccess){
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatView.id, arguments: userEmail);
          isLoading = false;
        }
        else if (state is LoginFailure){
          showSnackbar(context, state.errMessage);
          isLoading = false;


        }
      },
      child:ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  textColor,
                  textColor,
                  primaryColor,
                  const Color(0xff1ea0a1),
                  textColor,
                ],
                begin: Alignment.bottomLeft,
              )
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.only(
                  top: 200,
                  left: 10,
                  right: 10
              ),
              child: Form(
                key: formKey,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontFamily: appFont,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    CustomTextFormField(
                      onChanged: (String data) {
                        userEmail = data;
                      },
                      hint: 'Email',
                    ),
                    CustomTextFormField(
                      onChanged: (String data) {
                        userPassword = data;
                      },
                      hint: 'Password',
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButon(
                      text: 'Login',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(LoginEvent(userEmail: userEmail!, userPassword: userPassword!));
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Do not have an account?',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: appFont,
                              fontSize: 15
                          ),),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SignInView.id);
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: appFont,
                                fontSize: 15
                            ),),
                        )

                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
