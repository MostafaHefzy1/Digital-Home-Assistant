import 'package:http/http.dart' as http;
import 'dart:convert';


import '../../models/chat_message_model.dart';


Future<ChatMessageModel> generateTextFromGPT3(String prompt) async {
  const apiKey = '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';
  const apiUrl = 'https://api.openai.com/v1/engines/text-davinci-003/completions';
  
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'prompt': prompt,
      'max_tokens': 100,
    }),
  );

  if (response.statusCode == 200) {
    var myDataString = utf8.decode(response.bodyBytes);

    final data = jsonDecode(myDataString);
    final generatedText =  data['choices'][0]['text'];
    return ChatMessageModel(messageContent: generatedText, messageType: 'receiver') ;
  } else {
    return ChatMessageModel(messageContent: 'Failed to generate text', messageType: 'receiver') ;
  }
}

