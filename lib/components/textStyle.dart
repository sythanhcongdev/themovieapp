import 'package:flutter/material.dart';

TextStyle textStyle(double size) {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: size,
    color: const Color(0xffFFFFFF),
    fontFamily: 'Gilroy',
  );
}

Text textHeader(String textName) {
  return Text(
    textName,
    textAlign: TextAlign.center,
    style: textStyle(15),
  );
}

Widget iconBottom(IconData icon, double sizeIcon) {
  return Icon(
    icon,
    size: sizeIcon,
    color: const Color.fromRGBO(180, 180, 180, 1),
  );
}
Widget iconRate(IconData icon) {
  return Icon(
    icon,
    size: 18,
    color: Color.fromARGB(255, 240, 92, 92),
  );
}
Widget textButton(String text) {
  return Text(
    text,
    style: textStyle(
      8,
    ),
  );
}

Widget textNameTitle(String text) {
  return Text(
    text,
    style: textStyle(
      20,
    ),
  );
}

 BoxDecoration textUnderline() {
    return const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Color(0xFF838282),
          width: 0.5,
        ),
        top: BorderSide(
          color: Color(0xFF838282),
          width: 0.5,
        ),
      ),
      color: Color(0xFF3D3D3D),
    );
  }

  BoxDecoration textUnderlineChild() {
    return const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Color(0xFF838282),
          width: 0.5,
        ),
      ),
      color: Color(0xFF3D3D3D),
    );
  }