import 'dart:ui';

import 'package:flutter/material.dart';
import '../components/textStyle.dart';

Widget bottomListMovie() {
  return ClipRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 200),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconBottom(Icons.star, 20),
                const SizedBox(height: 2),
                textButton('Discover'),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconBottom(Icons.list_rounded, 20),
                const SizedBox(height: 2),
                textButton('My Lists'),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconBottom(Icons.search, 20),
                const SizedBox(height: 2),
                textButton('Search'),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconBottom(Icons.newspaper, 20),
                const SizedBox(height: 2),
                textButton('News'),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconBottom(Icons.settings, 20),
                const SizedBox(height: 2),
                textButton('Settings'),
              ],
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    ),
  );
}
