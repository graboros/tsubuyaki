this.check_content_present = ->
  if $("input.message").val() == ""
    alert("メッセージを入力してください");
    return false;

  return true;

this.check_present_onnew = ->
  if $("input[type=checkbox]:checked").size() == 0
    alert("メッセージ送信先のユーザを入力してください");
    return false;

  return this.check_content_present();
