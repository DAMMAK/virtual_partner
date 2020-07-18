import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:flutter_dialogflow/v2/auth_google.dart';
import 'package:flutter_dialogflow/v2/dialogflow_v2.dart';

class Bot {
  Bot() {
    //_init();
  }
  static _init() async {
    AuthGoogle _authGoogle = await AuthGoogle(fileJson: "assets/small-talk-duvbxs-65dcf602fcbe.json").build();
    Dialogflow _dialogflow = Dialogflow(authGoogle: _authGoogle, language: Language.english);
    return _dialogflow;
  }

  static dynamic sendMessage({String query}) async {
    try {
      var dialogflow = await _init();
      AIResponse response = await dialogflow.detectIntent(query);
      print(response.getMessage());
      return response;
    } catch (e) {
      print("Encountered an exception with dialog flow ${e.toString()}");
    }
  }
}
