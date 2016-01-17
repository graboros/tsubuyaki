this.addAlert = (msg) ->
  $("span.alert").css("display", "none")
  $("span.alert-danger").text(msg).css("display", "inline")

this.addNotice = (msg) ->
  $("span.alert").css("display", "none")
  $("span.alert-info").text(msg).css("display", "inline")
