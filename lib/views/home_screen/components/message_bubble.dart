import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_application/consts/consts.dart';
import 'package:get/get.dart';

import '../../chat_screen.dart/chat_screen.dart';
import 'package:intl/intl.dart' as intl;

Widget messageBubble(DocumentSnapshot doc) {
  var t = doc['created_on'] == null ? DateTime.now() : doc['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  return Card(
    child: ListTile(
      onTap: () {
        Get.to(
          () => const ChatScreen(), transition: Transition.downToUp,
          //lets pass the argument
          arguments: [
            //lets add demo values when we open any chat from our home screen
            //because we have not done that part yet
            //same goes here
            currentUser!.uid == doc['toId'] ? doc['friend_name'] : doc['user_name'],
            currentUser!.uid == doc['toId'] ? doc['fromId'] : doc['toId']
            //lets see if it opens correct chat
            //everything works.. lets fix some other things
          ],
        );
      },
      leading: CircleAvatar(
          backgroundColor: btnColor,
          radius: 20,
          child: Image.asset(
            icUser,
            color: Colors.white,
          )),
      //if current user is not the one who sent the message then show sender name else show friendname
      title: currentUser!.uid == doc['toId']
          ? "${doc['friend_name']}".text.fontFamily(semibold).size(14).make()
          : "${doc['user_name']}".text.fontFamily(semibold).size(14).make(),
      subtitle: "${doc['last_msg']} ".text.maxLines(1).size(14).make(),
      trailing: Directionality(
        textDirection: TextDirection.rtl,
        child: TextButton.icon(
            onPressed: null,
            icon: const Icon(
              Icons.access_time_filled_rounded,
              size: 16,
              color: Vx.gray400,
            ),
            label: time.text.color(Vx.gray400).size(12).make()),
      ),
    ),
  );
}
