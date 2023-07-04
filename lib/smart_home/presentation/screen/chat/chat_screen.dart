import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:zeze_mobile/core/util/app_images.dart';
import 'package:zeze_mobile/core/util/app_strings.dart';
import '../../../../core/models/chat_message_model.dart';
import '../../../../core/network/provider/chat_gpt_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatTextController = TextEditingController();

  var messages = <ChatMessageModel>[];

  @override
  void dispose() {
    chatTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: Image.asset(AppImages.chatGptImage).image,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                AppStrings.askAnyQuestion,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              // height: (MediaQuery.of(context).size.height / 1.2),
              child: ListView.builder(
                itemCount: messages.length,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (messages[index].messageType == "receiver"
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (messages[index].messageType == "receiver"
                                ? Colors.grey.shade200
                                : Colors.blue[200]),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            messages[index].messageContent,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black87),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: chatTextController,
                      style: const TextStyle(color: Colors.black54),
                      decoration: const InputDecoration(
                        hintText: "اكتب رسالة ...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () => sendMessage(),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
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

  void sendMessage() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // call your function here
    await myFunction();

    // Close the modal dialog after the function is completed
    Navigator.pop(context);
  }

  Future<void> myFunction() async {
    var text = chatTextController.text.trim().toLowerCase();
    FocusScope.of(context).unfocus();
    setState(() {
      messages.add(
        ChatMessageModel(
          messageContent: text,
          messageType: 'sender',
        ),
      );
    });
    chatTextController.clear();
    if (checkIFUserDontWantToUseChatGPT(text)) {
      // Check if the app has permission to access the user's contacts
      var isContactAccessible = await Permission.contacts.status;

      // If the app doesn't have permission to access the contacts, ask for it
      if (!isContactAccessible.isGranted) {
        await Permission.contacts.request();
      }

      // Check if the app is still denied access to the contacts
      isContactAccessible = await Permission.contacts.status;
      if (isContactAccessible.isDenied) {
        // If so, return and don't continue with the rest of the function
        return;
      }

      // If the app has permission to access the contacts, get a list of all the contacts
      var contacts = await ContactsService.getContacts();

      // Find the first contact in the list that has a display name that matches
      // the search text.
      var contact = contacts.firstWhere(
        (element) {
          // If the contact doesn't have a display name, exclude it from the results.

          if (element.displayName == null) {
            return false;
          }

          // Check if the search text is contained within the display name (ignoring case).

          return text.contains(element.displayName!.toLowerCase());
        },
        // If no contact is found that matches the search text, return a default
        // Contact object with empty display name and phones list.
        orElse: () => Contact(displayName: '', phones: []),
      );

      if (contact.phones!.isEmpty) {
        var contactNamesWithSameName = contacts
            .where((element) {
              // Check if the contact has a display name. If not, return.
              if (element.displayName == null) {
                return false;
              }

              // Split the display name into individual names, accounting for double spaces.
              var names = element.displayName!.split(RegExp(r'\s+'));

              // Check if any of the names has less than 2 letters.
              var shortNames = names.where((name) => name.length >= 3);

              // Check if any of the names matches the search text.
              var nameMatch = shortNames.any((name) {
                return text.contains(name.toLowerCase());
              });
              // If there is a match, return true; otherwise, return false.
              return nameMatch;
            })
            .map((element) => element.displayName!)
            .toList();

        setState(() {
          messages.add(
            ChatMessageModel(
              messageContent:
                  'choose one of the following contacts:\n${contactNamesWithSameName.join('\n')}',
              messageType: 'receiver',
            ),
          );
        });
        return;
      }

      if (checkIFUserWantToCall(text)) {
        setState(() {
          messages.add(
            ChatMessageModel(
              messageContent: 'Calling ${contact.displayName}',
              messageType: 'receiver',
            ),
          );
        });

        launchUrlString("tel://${contact.phones?.first.value}");
      }
      if (checkIFUserWantToSendSMS(text)) {
        setState(() {
          messages.add(
            ChatMessageModel(
              messageContent: 'sending SMS To ${contact.displayName}',
              messageType: 'receiver',
            ),
          );
        });
        launchUrlString("sms://${contact.phones?.first.value}");
      }
      if (checkIFUserWantToSendWhatsApp(text)) {
        setState(() {
          messages.add(
            ChatMessageModel(
              messageContent: 'sending message To ${contact.displayName}',
              messageType: 'receiver',
            ),
          );
        });
        launchUrlString("whatsapp://send?phone=${contact.phones?.first.value}");
      }
    } else {
      final response = await generateTextFromGPT3(text);
      setState(() {
        messages.add(response);
      });
    }
  }
}

bool checkIFUserWantToCall(text) {
  if (text.toLowerCase().startsWith('call')) return true;
  if (text.toLowerCase().contains('اتصل')) return true;
  if (text.toLowerCase().contains('كلم')) return true;
  if (text.toLowerCase().contains('كول')) return true;

  return false;
}

bool checkIFUserWantToSendSMS(text) {
  if (text.toLowerCase().contains('sms')) return true;
  if (text.toLowerCase().contains('رساله')) return true;

  return false;
}

bool checkIFUserWantToSendWhatsApp(text) {
  if (text.toLowerCase().contains('whatsapp')) return true;
  if (text.toLowerCase().contains('وتساب')) return true;
  return false;
}

bool checkIFUserDontWantToUseChatGPT(String text) {
  if (checkIFUserWantToCall(text)) {
    return true;
  }

  if (checkIFUserWantToSendWhatsApp(text)) {
    return true;
  }

  if (checkIFUserWantToSendSMS(text)) {
    return true;
  }

  return false;
}
