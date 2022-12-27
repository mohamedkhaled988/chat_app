import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/core/app_strings.dart';
import 'package:chat_app/features/presentation/model/model.dart';
import 'package:chat_app/features/presentation/widgets/chat_bubble.dart';
import 'package:chat_app/features/presentation/service/fire_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/friend_chat_bubble.dart';

class ChatPage extends StatelessWidget {
  String? _message;
  final _firestore = FireStore();
  TextEditingController controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments ;
    final AppBar appBar = AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/chat.png",
            height: 50.0,
          ),
          const Text(AppStrings.appName)
        ],
      ),
      automaticallyImplyLeading: false, // عشان يشيل السهم اللي في الاول
    );
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.loadMessage(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messages = [];
          for (var doc in snapshot.data!.docs) {
            Map? data = doc.data() as Map?;
            messages.add(
              Message(
                message: data![AppStrings.kMessage],
                createdTime: data![AppStrings.timeCreated],
                id: data![AppStrings.id],
              ),
            );
          }
          return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                "assets/images/me.jpeg",
              ),
              fit: BoxFit.cover,
            )),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: appBar,
              body: Column(
                children: [
                  Expanded(
                    // هتخلي ال list view تكبر علي حسب المساحة المتاحة ليها عشان اقدر احط المربع اللي تحت واللي بحط فيه الرسايل
                    child: ListView.builder(
                      reverse: true,
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return messages[index].id == email
                            ? ChatBubble(
                                message: messages[index].message,
                              )
                            : FriendChatBubble(
                                message: messages[index].message,
                              );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: controller,
                      onChanged: (data) {
                        _message = data;
                      },
                      cursorColor: AppColors.primary,
                      decoration: InputDecoration(
                        hintText: "Send Message",
                        filled: true,
                        fillColor: Colors.white.withOpacity(.3),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _firestore.addMessage(
                              Message(
                                message: _message!,
                                createdTime: DateTime.now(),
                                id: email,
                              ),
                            );
                            controller.clear();
                            _scrollController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.fastOutSlowIn,
                            );
                          },
                          child: Icon(
                            Icons.send,
                            color: AppColors.primary,
                            size: 30,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(
                                color: AppColors.primary, width: 3.0)),
                        enabledBorder: OutlineInputBorder(
                            // عشان يعمل شكل المستطيل ويديه حدود وكده
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(
                                color: AppColors.primary, width: 3.0)),
                        focusedBorder: OutlineInputBorder(
                            // عشان لما اضغط عليه يفضل نفس الشكل زي في اللي فات
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                                color: AppColors.primary, width: 3.0)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
