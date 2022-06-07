import 'dart:ui';

import 'package:flutter/material.dart';
import '../components/textStyle.dart';

Widget header() {
  return Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff626275),
          ),
    child: ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 200.0,
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          right:
                              BorderSide(width: 1.0, color: Color(0xffECECEB)))),
                  child: textHeader('In Theaters')),
            ),
            Expanded(
              child: textHeader('Upcoming'),
            ),
          ],
        ),
      ),
    ),
  );
}

Text textHeader(String textName) {
  return Text(
    textName,
    textAlign: TextAlign.center,
    style: textStyle(15,),
  );
}
