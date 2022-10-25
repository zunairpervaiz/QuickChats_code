import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_application/consts/consts.dart';
import 'package:demo_application/controllers/home_controller.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  //varibales for chat
  dynamic chatId;
  var chats = firebaseFirestore.collection(collectionChats);
  var userId = currentUser!.uid;
  //now as we are passing the arguments we can get them
  var friendId = Get.arguments[1];
  //it will get the name from the prefs 0 index
  var username = HomeController.instance.prefs.getStringList('user_details')![0];
  //get through argument
  var friendname = Get.arguments[0];

  //text controller
  var messageController = TextEditingController();

  var isloading = false.obs;

  //creating chatroom
  getChatId() async {
    //it will see if there is a chatroom already created between the 2 users
    isloading(true);
    await chats
        .where('users', isEqualTo: {friendId: null, userId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) async {
          if (snapshot.docs.isNotEmpty) {
            //if chatroom is already created then assign the id to our chatId variable
            chatId = snapshot.docs.single.id;
          } else {
            //if no room is created then create one
            chats.add({
              'users': {userId: null, friendId: null},
              'friend_name': friendname,
              'user_name': username,
              'toId': '',
              'fromId': '',
              "created_on": null,
              'last_msg': ''
            }).then((value) {
              //assign the doc id to our chatid variable
              {
                chatId = value.id;
              }
              //we have created a room for them
            });
          }
        });
    //when id is obtained make isloading false again
    isloading(false);
  }

  //send message method

  sendmessage(String msg) {
    if (msg.trim().isNotEmptyAndNotNull) {
      //if msg is not empty or null
      //first update the chat id doc and then save the message to database

      chats.doc(chatId).update({
        //here we are going to post server time stamp
        'created_on': FieldValue.serverTimestamp(),
        //because of this type mistake i had to remove the field and add it by myself
        //lets test again
        'last_msg': msg,
        'toId': friendId,
        'fromId': userId
      });
      //now save the msg in database
      //here we are creating another collection named message
      chats.doc(chatId).collection(collectionMessages).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        //uid is used to identify who send the msg
        'uid': userId
      }).then((value) {
        //after msg is send and saves clear the textfield
        messageController.clear();
      });
    }
  }

  @override
  void onInit() {
    getChatId();
    super.onInit();
  }
}
