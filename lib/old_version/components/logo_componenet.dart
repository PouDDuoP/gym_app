import 'package:flutter/material.dart';

class LogoComponenet extends StatefulWidget {
  const LogoComponenet({super.key});

  @override
  State<LogoComponenet> createState() => _LogoComponenetState();
}

class _LogoComponenetState extends State<LogoComponenet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 64),
      child: Column(
        children: [
          Image.network(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}