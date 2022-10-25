import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_application/consts/consts.dart';
import 'package:demo_application/controllers/chats_controller.dart';
import 'package:demo_application/services/store_services.dart';
import 'package:demo_application/views/chat_screen.dart/components/chat_bubble.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //init our chats controller
    var controller = Get.put(ChatController());

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: const [
          Icon(
            Icons.more_vert_rounded,
            color: Colors.white,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Expanded(
                      child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          //use the username from the chatscreen
                          text: "${controller.friendname}\n",
                          style: const TextStyle(fontFamily: semibold, fontSize: 16, color: txtColor),
                        ),
                        const TextSpan(
                            text: "Last seen",
                            style: TextStyle(
                              fontFamily: semibold,
                              fontSize: 12,
                              color: greyColor,
                            )),
                      ],
                    ),
                  )),
                  const CircleAvatar(
                    backgroundColor: btnColor,
                    child: Icon(
                      Icons.video_call_rounded,
                      color: Colors.white,
                    ),
                  ),
                  10.widthBox,
                  const CircleAvatar(
                    backgroundColor: btnColor,
                    child: Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            30.heightBox,
            //this is our chat body
            Obx(
              () => Expanded(
                //here we are going to use stream builder for realtime chat
                //but first we need to send a message

                //if isloading value is true? show progress indicator else show our chat
                child: controller.isloading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(bgColor),
                        ),
                      )
                    : StreamBuilder(
                        //set stream method
                        stream: StoreServices.getChats(controller.chatId),

                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            //if no data is receievd yet
                            return Container();
                          } else {
                            //lets get all the messages in mapped
                            return ListView(
                              children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                                //here we are going to pass our chat bubbles
                                //we got two messages, lets fix them
                                //lets convert each msg into a variable for easy access
                                var doc = snapshot.data!.docs[index];
                                //we are passing this doc to our chat bubble
                                return chatBubble(index, doc);
                              }).toList(),
                            );
                            //all errors fixed
                          }
                        },
                      ),
              ),
            ),
            10.heightBox,
            SizedBox(
              height: 56,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(
                        //set message controller here
                        controller: controller.messageController,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.emoji_emotions_rounded,
                            color: greyColor,
                          ),
                          suffixIcon: Icon(
                            Icons.attachment_rounded,
                            color: greyColor,
                          ),
                          border: InputBorder.none,
                          hintText: "Type message here...",
                          hintStyle: TextStyle(fontFamily: semibold, fontSize: 12, color: greyColor),
                        ),
                      ),
                    ),
                  ),
                  20.widthBox,
                  GestureDetector(
                    onTap: () {
                      //ontap of this send message
                      controller.sendmessage(controller.messageController.text);
                      //okay now lets send a message
                      //now lets show them
                    },
                    child: const CircleAvatar(
                      backgroundColor: btnColor,
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
