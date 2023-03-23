import 'package:antreeorder/screens/login/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../components/export_components.dart';
import '../../models/user.dart';
import '../../utils/export_utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  var _isHiddenPassword = true;
  var _isHiddenConfirmPassword = true;
  var _password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: const AntreeBack(),
      ),
      body: SafeArea(
          child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) => _listContent(context)[index],
              separatorBuilder: ((context, index) => const SizedBox(
                    height: 20,
                  )),
              itemCount: _listContent(context).length)),
    );
  }

  List<Widget> _listContent(BuildContext context) => [
        const AntreeText(
          "Register",
          textType: AntreeTextType.title,
        ),
        FormBuilder(
          key: _formKey,
          child: Column(
            children: [
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
              AntreeTextField(
                'password',
                isObscureText: _isHiddenPassword,
                label: "Password",
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      _password = value;
                    }
                  });
                },
                suffixIcon: IconButton(
                  onPressed: onTogglePassword,
                  icon: Icon(_isHiddenPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                validators: [FormBuilderValidators.minLength(8)],
              ),
              const SizedBox(
                height: 16,
              ),
              AntreeTextField(
                'confirm_password',
                isObscureText: _isHiddenConfirmPassword,
                label: "Confirm Password",
                suffixIcon: IconButton(
                    onPressed: onToggleConfirmPassword,
                    icon: Icon(_isHiddenConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off)),
                validators: [
                  FormBuilderValidators.equal(_password,
                      errorText: "This field value must be same with password.")
                ],
              )
            ],
          ),
        ),
        AntreeButton(
          name: "Register",
          onclick: () {
            onClickRegister(context);
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

  void onClickRegister(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final name = _formKey.currentState?.value["name"];
      final username = _formKey.currentState?.value["username"];
      final password = _formKey.currentState?.value["password"];
      final user = User(
        name: name,
        username: username,
        password: password,
      );
    }
  }

  void onTogglePassword() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  void onToggleConfirmPassword() {
    setState(() {
      _isHiddenConfirmPassword = !_isHiddenConfirmPassword;
    });
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
