import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_application/consts/consts.dart';
import 'package:demo_application/services/store_services.dart';
import 'package:demo_application/views/home_screen/components/message_bubble.dart';

Widget chatsComponent() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    //using stream builder for realtime messages
    child: StreamBuilder(
      //set stream method
      stream: StoreServices.getMessages(),
      //lets edit our message

      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          //if not data received yet
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(bgColor),
            ),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          //if no messages found
          return Center(
            child: "Start a conversation...".text.fontFamily(semibold).color(txtColor).make(),
          );
        } else {
          //return our widget
          return ListView(
            //mapp all the data received
            children: snapshot.data!.docs.mapIndexed((currentValue, index) {
              //convert each msg into a variable for easy access
              var doc = snapshot.data!.docs[index];
              //pass this doc to our msgbubble
              return messageBubble(doc);
            }).toList(),
          );
        }
      },
    ),
  );
}
