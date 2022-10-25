import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_application/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

Widget chatBubble(index, DocumentSnapshot doc) {
  //lets fix who send the message
  //now lets fix the time
  var t = doc['created_on'] == null ? DateTime.now() : doc['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);

  //time is also fixed.. now lets change the ids to see everything works
  //after chaging uid we can see that whoever sends the message it will be black for him

  return Directionality(
    textDirection: doc['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: doc['uid'] == currentUser!.uid ? bgColor : btnColor,
            child: Image.asset(
              icUser,
              color: Colors.white,
            ),
          ),
          20.widthBox,
          Expanded(
              child: Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: doc['uid'] == currentUser!.uid ? bgColor : btnColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: "${doc['msg']}".text.fontFamily(semibold).white.make(),
            ),
          )),
          10.widthBox,
          Directionality(textDirection: TextDirection.ltr, child: time.text.color(greyColor).size(12).make())
        ],
      ),
    ),
  );
}
