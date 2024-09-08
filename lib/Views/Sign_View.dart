import 'package:chat_app/Blocs/auth_bloc.dart';
import 'package:chat_app/Blocs/auth_event.dart';
import 'package:chat_app/Blocs/auth_state.dart';
import 'package:chat_app/Components/Custom_Button.dart';
import 'package:chat_app/Components/Custom_Snack_Bar.dart';
import 'package:chat_app/Components/Custom_Text_Field.dart';
import 'package:chat_app/Constants.dart';
import 'package:chat_app/Views/Chat_View.dart';
import 'package:chat_app/Views/Login_View.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class SignInView extends StatelessWidget {
  static String id = 'Sign in View';

  String? userEmail;
  String? userPassword;

  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
      if (state is RegisterLoading){
        isLoading =true;
      }
      else if (state is RegisterSuccess){
        Navigator.pushNamed(context, ChatView.id, arguments: userEmail);
        isLoading = false;
      }
      else if (state is RegisterFailure){
        showSnackbar(context, state.errMessage);
        isLoading = false;
      }},
      builder: (context, state) {
        return ModalProgressHUD(
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
                )),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.only(top: 200, left: 10, right: 10),
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      Text(
                        'Sign in',
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
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButon(
                        text: 'Sign in',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(RegisterEvent(userEmail: userEmail!, userPassword: userPassword!));


                            // isLoading=true;
                            // setState(() {});
                            // try {
                            //   await registerUser();
                            //   Navigator.pushNamed(context, ChatView.id, arguments: userEmail);
                            // } on FirebaseAuthException catch (e) {
                            //   if (e.code == 'weak-password') {
                            //     showSnackbar(context,'password provided is too weak');
                            //   }
                            //   else if (e.code == 'email-already-in-use') {
                            //     showSnackbar(context,'email already exists' );
                            //   }
                            // } catch (e){
                            //   showSnackbar(context, 'there was an error');
                            // }
                            // isLoading = false ;
                            // setState(() {});

                          }
                          else {

                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'already have an account?',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: appFont,
                                fontSize: 15),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, LoginView.id);
                            },
                            child: Text(
                              'back to login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: appFont,
                                  fontSize: 15),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }


}
