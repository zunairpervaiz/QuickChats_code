import 'package:demo_application/consts/consts.dart';
import 'package:demo_application/controllers/home_controller.dart';

Widget appbar(GlobalKey<ScaffoldState> key) {
  return Container(
    padding: const EdgeInsets.only(right: 12),
    height: 70,
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            key.currentState!.openDrawer();
          },
          child: Container(
            decoration: const BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(100), bottomRight: Radius.circular(100))),
            height: 70,
            width: 80,
            child: const Icon(
              settingsIcon,
              color: Colors.white,
            ),
          ),
        ),
        appname.text.xl2.color(txtColor).fontFamily(bold).make(),
        CircleAvatar(
          backgroundColor: btnColor,
          radius: 20,
          child: Image.network(
            HomeController.instance.userImage,
          ).box.roundedFull.clip(Clip.antiAlias).make(),
        ),
      ],
    ),
  );
}
