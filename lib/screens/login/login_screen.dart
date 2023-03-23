import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../components/export_components.dart';
import '../../models/user.dart';
import '../../utils/export_utils.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  var _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 150),
            itemBuilder: (context, index) => _getWidget(context)[index],
            separatorBuilder: ((context, index) => const SizedBox(
                  height: 20,
                )),
            itemCount: _getWidget(context).length),
      ),
    );
  }

  List<Widget> _getWidget(BuildContext context) => [
        const AntreeText(
          "Login",
          textType: AntreeTextType.title,
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
              AntreeTextField(
                'password',
                isObscureText: _isHidden,
                label: "Password",
                suffixIcon: IconButton(
                    onPressed: onTogglePassword,
                    icon: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off)),
              )
            ],
          ),
        ),
        AntreeButton(
          name: "Login",
          onclick: () {
            onClickLogin(context);
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

  void onClickLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final username = _formKey.currentState?.value["username"];
      final password = _formKey.currentState?.value["password"];
      final user = User(
        username: username,
        password: password,
      );
      // context.read<LoginBloc>().add(LoginUserEvent(_user));
    }
  }

  void onTogglePassword() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
