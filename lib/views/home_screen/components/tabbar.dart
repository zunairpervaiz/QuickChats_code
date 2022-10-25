import 'package:demo_application/consts/consts.dart';

Widget tabbar() {
  return const RotatedBox(
    quarterTurns: 3,
    child: TabBar(
      labelColor: btnColor,
      labelStyle: TextStyle(fontFamily: bold, fontSize: 14),
      unselectedLabelStyle: TextStyle(fontFamily: semibold, fontSize: 14),
      unselectedLabelColor: lightgreyColor,
      indicator: BoxDecoration(),
      tabs: [
        Tab(text: chats),
        Tab(text: status),
        Tab(text: camera),
      ],
    ),
  );
}
