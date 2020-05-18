import 'dart:html';

main() {
  document.getElementById("emoji_1").onInput.listen(inputEmojiAction);
  document.getElementById("emoji_2").onInput.listen(inputEmojiAction);
  document.getElementById("suumoTextBox").onInput.listen(inputTextAction);
  document.getElementById("typeSelect").onChange.listen(changedType);
  document.getElementById("fontType").onChange.listen((e) {
    document.getElementById("resultText").setInnerHtml(textSuumoGenerator(
        document.getElementById("suumoTextBox").value, false));
  });
}

inputEmojiAction(Event event) {
  var eyeEmoji = document.getElementById("emoji_1").value;
  var bodyEmoji = document.getElementById("emoji_2").value;
  document
      .getElementById("resultText")
      .setInnerHtml(emojiSuumoGenerator(eyeEmoji, bodyEmoji, false));
}

inputTextAction(Event event) {
  document.getElementById("resultText").setInnerHtml(
      textSuumoGenerator(document.getElementById("suumoTextBox").value, false));
}

changedType(Event event) {
  suumoReset();
  document.getElementById("emojiSelect").style.display = "none";
  document.getElementById("textSelect").style.display = "none";

  document
      .getElementById(
          event.target.value == "emoji" ? "emojiSelect" : "textSelect")
      .style
      .display = "";
}

emojiSuumoGenerator(String eyeEmoji, String bodyEmoji, bool innerTextArea) {
  var resultText = suumo.replaceAll("👁", eyeEmoji).replaceAll("🌳", bodyEmoji);
  return innerTextArea
      ? resultText.replaceAll("end", "")
      : resultText.replaceAll(" ", "&nbsp;").replaceAll("end", "<br>");
}

textSuumoGenerator(String text, bool innerTextArea) {
  //emojiは二文字扱い
  var resultText = suumo.replaceAll(" ", "&nbsp;").replaceAll("end", "<br>");
  if (document.getElementById("fontType").value == "全角") {
    for (var i = 0; i <= text.length - 1; i++) {
      resultText = resultText.replaceFirst("🌳", text[i] + "&nbsp;");
    }
  } else {
    for (var i = 0; i <= text.length - 1; i++) {
      if (i % 2 == 1) {
        resultText = resultText.replaceFirst("🌳", text[i] + "🌳");
      } else {
        resultText = resultText.replaceFirst("🌳", text[i]);
      }
    }
  }

  return resultText;
}

suumoReset() {
  document
      .getElementById("resultText")
      .setInnerHtml(suumo.replaceAll(" ", "&nbsp;").replaceAll("end", "<br>"));
}

String suumo = """
       🌳🌳🌳end
    🌳🌳🌳🌳🌳🌳end
  🌳🌳👁🌳🌳👁🌳🌳end
 🌳🌳🌳🌳🌳🌳🌳🌳🌳end
 🌳🌳🌳🌳🌳🌳🌳🌳🌳end
  🌳🌳🌳🌳🌳🌳🌳🌳end
    🌳🌳🌳🌳🌳🌳end
      🌳🌳🌳🌳end
        」　」""";
