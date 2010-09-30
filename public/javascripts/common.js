var Tasklist = { };

// Lists

var sortableTaskListOptions = {
  update: function(ev, ui){
    var $list = $(this).parents(".list"),
        $lis  = $("li", $list),
        $form = $(".reorder_form", $list),
        task_id = $(ui.item).attr("data-id"),
        position = ($lis.length - $lis.index(ui.item) - 1);
    
    $(".task_id", $form).val(task_id);
    $(".position", $form).val(position);
    $form.submit();
  }
};

var autocompleteSharingOptions = {
  source: function(request, response){
    $.ajax({
      url: $("input#search_path").val(),
      dataType: "json",
      data: { q: request.term },
      success: function(data) {
        response(
          $.map(data, function(user){
            return { label: user.username, value: user.username }
          }));
      }
    });
  },
  minLength: 2,
  select: function(event, ui){
    if (ui.item) {
      $(this).addClass("username_valid");
      $(".share_form input.username").val(ui.item.value);
    } else {
      $(".share_form input.username").val("");
    }
  },
  open: function(){
    console.log("opened");
    $(".share_form input.username").val("");
  },
  close: function(){
    console.log("closed");
  }
};

Tasklist.lists = {
  create : function(ev) {
    var $list = $(ev.list_html).prependTo("#lists");
    $("#list_name").val("");
    $(".tasks", $list).sortable(sortableTaskListOptions)
    $("input.ac_username", $list).autocomplete(autocompleteSharingOptions);
    $("#"+ev.list_id+"_task_task").focus();
  },
  
  destroy : function(ev) {
    $(".list[data-id="+ev.list_id+"]").slideUp("fast", function(){
      $(this).remove();
    });
  },
  
  share : function(ev) {
    var $list = $(".list[data-id="+ev.list_id+"]");
    $("input.ac_username", $list).val("").removeClass("username_valid");
    $(ev.userHtml).prependTo(".share_form ul", $list);
    $(".input.username", $list).val(ui.item.value);
  }
};

$(document).bind("lists:create", Tasklist.lists.create);
$(document).bind("lists:destroy", Tasklist.lists.destroy);
$(document).bind("lists:share", Tasklist.lists.share);

$("ul#lists .share").toggle(function() {
  $(this).parents("li.list").find(".share_form").slideDown("fast");
}, function() {
  $(this).parents("li.list").find(".share_form").slideUp("fast");
});

$("ul.tasks").sortable(sortableTaskListOptions);
$(".list input.ac_username").autocomplete(autocompleteSharingOptions);

$("#share_list").submit(function(){
  return ($(".username", this).val().length > 0);
});

$("#new_list").submit(function(){
  return ($("#list_name").val().length > 0);
});

$(".list").each(function(){
  var list_id      = $(this).attr("data-id"),
      list_channel = socket.subscribe("private-list-" + list_id);
      
      list_channel.bind("task-create", function(e){ $(document).trigger(e) });
      list_channel.bind("task-toggle-complete", function(e){ $(document).trigger(e) });
      list_channel.bind("task-destroy", function(e){ $(document).trigger(e) });
      
      // presence_channel = socket.subscribe("presence-list-" + list_id),
      // presence_channel.bind("pusher:subscription_succeeded", function(member){
      //   console.log("member subscribed: " + member[0].user_info.name);
      // });
      // 
      // presence_channel.bind("pusher:member_added", function(member){
      //   console.log("member added: " + member.user_info.name);
      // });
      // 
      // presence_channel.bind("pusher:member_removed", function(member){
      //   console.log("member removed: " + member.user_info.name);
      // });
});

// Tasks

Tasklist.tasks = {
  create : function(ev) {
    $("#"+ev.list_id+"_task_task").val("");
    $(ev.task_html).prependTo(".list[data-id="+ev.list_id+"] .tasks");
  },
  
  complete : function(ev) {
    $(".task[data-id="+ev.task_id+"]").replaceWith(ev.task_html);
  },
  
  destroy : function(ev) {
    $(".task[data-id="+ev.task_id+"]").slideUp("fast", function(){
      $(this).remove();
    });
  }
};

$(document).bind("tasks:create", Tasklist.tasks.create);
$(document).bind("tasks:complete", Tasklist.tasks.complete);
$(document).bind("tasks:destroy", Tasklist.tasks.destroy);

$("#new_task").submit(function(){
  return ($("#new_task input.new_task").val().length > 0);
});
