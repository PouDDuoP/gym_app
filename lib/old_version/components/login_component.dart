import 'package:flutter/material.dart';

class LoginComponent extends StatefulWidget {
  const LoginComponent({super.key});

  @override
  State<LoginComponent> createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
              labelText: 'Enter your email',
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(),
              labelText: 'Enter your password',
            ),
          ),
        ),
      ],
    );
  }
}