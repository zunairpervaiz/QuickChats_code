import 'package:flutter/material.dart';
import '../../views.dart';

Widget tabbarView() {
  return Expanded(
    child: Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 8),
      decoration:
          const BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12)), color: Colors.white),
      child: TabBarView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: chatsComponent(),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: statusComponent(),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.yellow,
            ),
          ),
        ],
      ),
    ),
  );
}
