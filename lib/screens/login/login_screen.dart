import 'package:antreeorder/models/base_state.dart';
import 'package:antreeorder/models/login_dto.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:antreeorder/di/injection.dart';

import '../../components/export_components.dart';
import '../../res/export_res.dart';
import '../../utils/export_utils.dart';
import '../merchant_side/home/home_screen.dart' as merchant_home;
import '../register/register_screen.dart';
import '../user_side/home/home_screen.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final AntreeLoadingDialog _dialog;
  late final LoginBloc _loginBloc;

  @override
  void initState() {
    _dialog = getIt<AntreeLoadingDialog>();
    _loginBloc = getIt<LoginBloc>();
    _loginBloc.add(Initial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AntreeAppBar("", showBackButton: false, actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocSelector<LoginBloc, LoginState, bool>(
              bloc: _loginBloc,
              selector: (state) => state.isUser,
              builder: (context, state) => AntreeUserSwitcher(state,
                  onUserSwitch: (value) => _loginBloc.add(UserSwitch(value))),
            ),
          )
        ]),
        body: SafeArea(
          child: BlocListener<LoginBloc, LoginState>(
            bloc: _loginBloc,
            listener: (context, state) {
              if (state.status == StatusState.success) {
                _dialog.dismiss();
                _formKey.currentState?.reset();
                AppRoute.clearAll(state.isUser
                    ? const HomeScreen()
                    : const merchant_home.HomeScreen());
                context.snackbar.showSnackBar(AntreeSnackbar(
                  state.message,
                  status: SnackbarStatus.success,
                ));
              }
              if (state.status == StatusState.failure) {
                _dialog.dismiss();
                context.snackbar.showSnackBar(AntreeSnackbar(
                  state.message,
                  status: SnackbarStatus.error,
                ));
              }
            },
            child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 150),
                itemBuilder: (context, index) => _getWidget(context)[index],
                separatorBuilder: ((context, index) => const SizedBox(
                      height: 20,
                    )),
                itemCount: _getWidget(context).length),
          ),
        ),
      ),
    );
  }

  List<Widget> _getWidget(BuildContext context) => [
        AntreeText(
          "Login",
          style: AntreeTextStyle.title,
        ),
        FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              const AntreeTextField(
                'username',
                label: "Username",
              ),
              const SizedBox(
                height: 16,
              ),
              BlocSelector<LoginBloc, LoginState, bool>(
                bloc: _loginBloc,
                selector: (state) => state.isVisiblePassword,
                builder: (context, state) => AntreeTextField(
                  'password',
                  isObscureText: state,
                  label: "Password",
                  suffixIcon: IconButton(
                      onPressed: () =>
                          _loginBloc.add(PassWordVisibility(!state)),
                      icon: Icon(
                          state ? Icons.visibility : Icons.visibility_off)),
                ),
              )
            ],
          ),
        ),
        BlocSelector<LoginBloc, LoginState, bool>(
          bloc: _loginBloc,
          selector: (state) => state.isUser,
          builder: (context, state) {
            logger.d(state);
            return AntreeButton(
              "Login",
              onclick: () {
                onClickLogin(context, state);
              },
            );
          },
        ),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "No Account?",
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                      text: " Register.",
                      style: const TextStyle(color: Colors.blueAccent),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => AppRoute.to(const RegisterScreen()))
                ]))
      ];

  void onClickLogin(BuildContext context, bool isUser) {
    final formKeyState = _formKey.currentState;
    if (formKeyState != null && formKeyState.validate()) {
      _dialog.showLoadingDialog(context);
      formKeyState.save();
      final user = LoginDto.fromJson(formKeyState.value);
      _loginBloc.add(isUser ? LoginUser(user) : LoginMerchant(user));
    }
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
