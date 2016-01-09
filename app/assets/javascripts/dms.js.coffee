this.check_content_present= ->
  if $("input.message").val() == ""
    alert("メッセージを入力してください");
    return false;

  return true;
