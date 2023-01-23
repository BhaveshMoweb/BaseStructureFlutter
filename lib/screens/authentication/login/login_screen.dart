///    Created By Bhavesh Makwana on 10/01/23
import 'package:base_structure/components/common_title_text.dart';
import 'package:base_structure/screens/base_screen/base_screen.dart';
import 'package:base_structure/utils/app_colors.dart';
import 'package:base_structure/utils/app_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:sizer/sizer.dart';

import '../../../components/custom_text_field.dart';
import '../../../components/progressive_button.dart';
import '../../../model/login_request.dart';
import '../../../source_n_repository/authentication/authentication_datasource.dart';
import '../../../source_n_repository/authentication/authentication_repository.dart';
import '../../../utils/cm_file.dart';
import '../../../utils/routes.dart';
import '../../../utils/strings.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =
      TextEditingController(text: "mor_2314");
  TextEditingController passwordController =
      TextEditingController(text: "83r5^_");
  ButtonState buttonState = ButtonState.idle;

  LoginBloc loginBloc = LoginBloc(
      authenticationRepository:
          AuthenticationRepository(authDataSource: AuthenticationDataSource()));

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: loginBody(),
      shouldShowAppbar: false,
      shouldShowNoInternetScreen: false,
    );
  }

  Scaffold loginBody() {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          bloc: loginBloc,
          listener: (context, state) {
            /// login failure state
            if (state is LoginStateFailure) {
              buttonState = ButtonState.fail;
            }

            /// login busy state
            if (state is LoginStateBusy) {
              buttonState = ButtonState.loading;
            }

            /// login success state
            if (state is LoginStateSuccess) {
              buttonState = ButtonState.success;
              CM.showCustomToast(context, Strings.loginSuccessMessage,
                  isError: false);
              AppPreference.instance.savePrefBoolean(Pref.isLoggedIn, true);
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.productList,
                (Route<dynamic> route) => false,
              );
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            bloc: loginBloc,
            builder: (context, state) {
              return Form(
                child: Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Login Header text
                      CM.sb(5.h),
                      CommonTitleText(text: Strings.login),

                      /// email text field
                      CM.sb(5.h),
                      CommonTextField(
                        controller: emailController,
                        hint: Strings.email,
                      ),

                      /// password text field
                      CM.sb(2.h),
                      CommonTextField(
                        controller: passwordController,
                        hint: Strings.password,
                        isPassword: true,
                      ),

                      /// Login Button
                      CM.sb(10.h),
                      ProgressiveButton(
                        title: Strings.login,
                        initialButtonColor: AppColors.appBarHeadingColor,
                        onPressed: () {
                          serverCallForLogin();
                        },
                        buttonState: buttonState,
                        borderRadius: 20,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void serverCallForLogin() {
    if (emailController.text.toString().trim().isEmpty) {
      CM.showCustomToast(context, Strings.errEmptyEmail, isError: true);
    } else if (passwordController.text.toString().trim().isEmpty) {
      CM.showCustomToast(context, Strings.errEmptyEmail, isError: true);
    } else {
      LoginRequest loginRequest = LoginRequest(
        username: emailController.text,
        password: passwordController.text,
      );
      loginBloc.add(LoginUserEvent(loginRequest));
    }
  }
}
