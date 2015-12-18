this.tweet_keyup= ->
  rest = 140 - $("textarea.tweet").val().length || 0
  $typedCount = $("span.typed_count").text(rest)
  if rest < 0
    $typedCount.addClass("tweet_alert")
  else 
    $typedCount.removeClass("tweet_alert")

this.tweet_focusin= ->
  $("textarea.tweet").prop("rows", "3")
  $("span.typed_count,input.tweetbtn").css("display", "inline")

this.tweet_focusout= ->
  typedCount = $("textarea.tweet").val().length || 0
  if typedCount is 0
    $("textarea.tweet").prop("rows", "1")
    $("span.typed_count,input.tweetbtn").css("display", "none")
