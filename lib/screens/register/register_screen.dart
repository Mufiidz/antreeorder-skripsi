import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/base_state.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/screens/login/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../components/export_components.dart';
import '../../models/user.dart';
import '../../res/export_res.dart';
import '../../utils/export_utils.dart';
import 'bloc/register_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final RegisterBloc _registerBloc;
  late final AntreeLoadingDialog _dialog;
  var _password = '';

  @override
  void initState() {
    _registerBloc = getIt<RegisterBloc>();
    _dialog = getIt<AntreeLoadingDialog>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _registerBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AntreeAppBar(''),
        body: SafeArea(
            child: BlocListener<RegisterBloc, RegisterState>(
          bloc: _registerBloc,
          listener: (context, state) {
            if (state.status == StatusState.success) {
              _dialog.dismiss();
              context.snackbar.showSnackBar(AntreeSnackbar(state.message));
              _formKey.currentState?.reset();
              AppRoute.to(const LoginScreen());
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
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) => _listContent(context)[index],
              separatorBuilder: ((context, index) => const AntreeSpacer(
                    size: 20,
                  )),
              itemCount: _listContent(context).length),
        )),
      ),
    );
  }

  List<Widget> _listContent(BuildContext context) => [
        AntreeText(
          "Register",
          style: AntreeTextStyle.title,
        ),
        FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              AntreeDropdown(
                'category',
                items: const ['User', 'Merchant'],
                onValueChange: (p0) => _registerBloc.add(ConvertUser(p0)),
              ),
              const SizedBox(
                height: 16,
              ),
              const AntreeTextField(
                'name',
                label: "Name",
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(
                height: 16,
              ),
              const AntreeTextField(
                'username',
                label: "Username",
              ),
              const SizedBox(
                height: 16,
              ),
              BlocSelector<RegisterBloc, RegisterState, bool>(
                bloc: _registerBloc,
                selector: (state) => state.isVisiblePassword,
                builder: (context, state) {
                  return AntreeTextField(
                    'password',
                    isObscureText: state,
                    label: "Password",
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          _password = value;
                        }
                      });
                    },
                    suffixIcon: IconButton(
                      onPressed: () =>
                          _registerBloc.add(PassWordVisibility(!state)),
                      icon:
                          Icon(state ? Icons.visibility : Icons.visibility_off),
                    ),
                    validators: [FormBuilderValidators.minLength(8)],
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              BlocSelector<RegisterBloc, RegisterState, bool>(
                bloc: _registerBloc,
                selector: (state) => state.isVisibleConfirmPassword,
                builder: (context, state) {
                  return AntreeTextField(
                    'confirm_password',
                    isObscureText: state,
                    label: "Confirm Password",
                    suffixIcon: IconButton(
                        onPressed: () => _registerBloc
                            .add(ConfirmPassWordVisibility(!state)),
                        icon: Icon(
                            state ? Icons.visibility : Icons.visibility_off)),
                    validators: [
                      FormBuilderValidators.equal(_password,
                          errorText:
                              "This field value must be same with password.")
                    ],
                  );
                },
              )
            ],
          ),
        ),
        BlocSelector<RegisterBloc, RegisterState, bool>(
          bloc: _registerBloc,
          selector: (state) => state.isUser,
          builder: (context, state) {
            return AntreeButton(
              "Register",
              onclick: () => onClickRegister(context, state),
            );
          },
        ),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "Already have an account?",
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                      text: " Login.",
                      style: const TextStyle(color: Colors.blueAccent),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => AppRoute.to(const LoginScreen()))
                ]))
      ];

  void onClickRegister(BuildContext context, bool isUser) {
    final formKeyState = _formKey.currentState;
    if (formKeyState != null && formKeyState.validate()) {
      _dialog.showLoadingDialog(context);
      formKeyState.save();
      final user = User.fromJson(formKeyState.value);
      final merchant = Merchant.fromJson(formKeyState.value);
      _registerBloc
          .add(isUser ? RegisterUser(user) : RegisterMerchant(merchant));
    }
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
