import 'package:flutter/material.dart';

class AntreeButton extends StatelessWidget {
  final String name;
  final double? width;
  final double? height;
  final Function()? onclick;

  const AntreeButton({
    Key? key,
    required this.name,
    this.onclick,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onclick,
        style: ElevatedButton.styleFrom(
            elevation: 10,
            fixedSize: Size(width ?? 100, height ?? 50),
            backgroundColor: Colors.black,
            shape: const StadiumBorder()),
        child: Text(name,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.white)));
  }
}
