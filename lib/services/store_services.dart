import 'package:demo_application/consts/consts.dart';

class StoreServices {
  //get user data
  static getUser(String id) {
    return firebaseFirestore.collection(collectionUser).where('id', isEqualTo: id).get();
  }

  //get all users from our firebase users collection
  static getAllUsers() {
    return firebaseFirestore.collection(collectionUser).snapshots();
  }

  //get all chats

  static getChats(String chatId) {
    //it will get all the messages from
    //chats collection->chat id doc -> messages collection
    //here set orderby created_on and decending
    return firebaseFirestore
        .collection(collectionChats)
        .doc(chatId)
        .collection(collectionMessages)
        .orderBy('created_on', descending: true)
        .snapshots();
    //it will make the latest msg on the top and old message to the bottom
  }

  //get all messages
  static getMessages() {
    //get all messages from chats collection where users list include current user
    //and created_on is not equal to null means there should be atleast a message

    return firebaseFirestore
        .collection(collectionChats)
        .where("users.${currentUser!.uid}", isEqualTo: null)
        .where("created_on", isNotEqualTo: null)
        .snapshots();
  }
}
