import 'package:demo_application/consts/consts.dart';

Widget statusComponent() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: btnColor,
            child: Image.asset(
              icUser,
              color: Colors.white,
            ),
          ),
          title: "My status".text.fontFamily(semibold).color(txtColor).size(14).make(),
          subtitle: "Tap to add status updates".text.gray400.make(),
        ),
        20.heightBox,
        recentupdates.text.fontFamily(semibold).color(txtColor).make(),
        20.heightBox,
        ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: btnColor, width: 3),
                  ),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Vx.randomColor,
                    child: Image.asset(icUser),
                  ),
                ),
                title: "Username".text.fontFamily(semibold).size(14).color(txtColor).make(),
                subtitle: "Today, 8:47 PM".text.gray400.make(),
              ),
            );
          },
        ),
      ],
    ),
  );
}
