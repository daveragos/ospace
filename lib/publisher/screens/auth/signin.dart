import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:ospace/publisher/home_publisher.dart';

const users =  {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'OmniSpace',
      loginAfterSignUp: true,
      theme: LoginTheme(
        primaryColor: Colors.grey,
        titleStyle: TextStyle(color: Colors.green),

      ),
      additionalSignupFields: [
        UserFormField(
          keyName: 'username',
          defaultValue: 'username',
          displayName: 'Username',
          fieldValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'Username is required';
            }
            return null;
          },
          icon: Icon(Icons.person),
          userType: LoginUserType.name,
          tooltip: TextSpan(
            text: 'Username',
            style: TextStyle(color: Colors.black),
          )

        ),
      ],
      // termsOfService: [
      //   TermOfService(
      //     initialValue: true,
      //     text: 'By signing up, you agree to our Terms of Service and Privacy Policy.', id: 'tos',mandatory: true),
      //   TermOfService(text: 'I agree to the Terms of Service and Privacy Policy.', id: 'tos',mandatory: true),
      //   TermOfService(text: 'I agree to the Terms of Service and Privacy Policy.', id: 'tos',mandatory: true),

      // ],
      logo: const AssetImage('assets/img.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomePublisher(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}