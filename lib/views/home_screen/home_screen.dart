import 'package:demo_application/consts/colors.dart';
import 'package:demo_application/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    //init home controller
    var controller = Get.put(HomeController());

    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          key: scaffoldKey,
          drawer: drawer(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: btnColor,
            onPressed: () {
              //goto compose screen
              Get.to(() => const ComposeScreen(), transition: Transition.downToUp);
            },
            child: const Icon(Icons.edit),
          ),
          backgroundColor: bgColor,
          body: Column(
            children: [
              appbar(scaffoldKey),
              Expanded(
                child: Row(
                  children: [
                    tabbar(),
                    tabbarView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
