import 'package:demo_application/consts/consts.dart';
import 'package:demo_application/controllers/home_controller.dart';
import 'package:demo_application/main.dart';
import 'package:demo_application/views/views.dart';
import 'package:get/get.dart';

Widget drawer() {
  return Drawer(
    backgroundColor: bgColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(25)),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              backIcon,
              color: Colors.white,
            ).onTap(() {
              Get.back();
            }),
            title: setting.text.fontFamily(semibold).white.make(),
          ),
          20.heightBox,
          CircleAvatar(
            radius: 45,
            backgroundColor: btnColor,
            child: Image.network(
              HomeController.instance.userImage,
              fit: BoxFit.cover,
            ).box.roundedFull.clip(Clip.antiAlias).make(),
          ),
          10.heightBox,
          HomeController.instance.username.text.white.fontFamily(semibold).size(16).make(),
          20.heightBox,
          const Divider(color: btnColor, height: 1),
          10.heightBox,
          ListView(
            shrinkWrap: true,
            children: List.generate(
              drawerIconsList.length,
              (index) => ListTile(
                onTap: () {
                  switch (index) {
                    case 0:
                      Get.to(() => const ProfileScreen(), transition: Transition.downToUp);

                      break;
                    default:
                  }
                },
                leading: Icon(
                  drawerIconsList[index],
                  color: Colors.white,
                ),
                title: drawerListTitles[index].text.fontFamily(semibold).size(14).white.make(),
              ),
            ),
          ),
          10.heightBox,
          const Divider(color: btnColor, height: 1),
          10.heightBox,
          ListTile(
            leading: const Icon(
              inviteIcon,
              color: Colors.white,
            ),
            title: invite.text.fontFamily(semibold).size(14).white.make(),
          ),
          const Spacer(),
          ListTile(
            onTap: () async {
              await auth.signOut();
              Get.offAll(() => const ChatApp());
            },
            leading: const Icon(
              logoutIcon,
              color: Colors.white,
            ),
            title: logout.text.fontFamily(semibold).white.size(14).make(),
          ),
        ],
      ),
    ),
  );
}
