var Tasklist = { };

// Lists

var sortableTaskOptions = {
  update: function(ev, ui){
    var $lis = $("li", this),
        pos  = ($lis.length - $lis.index(ui.item) + 1);

    $.ajax({
      type: "POST",
      url: ui.item.attr("data-reorder-path"),
      data: { 
        _method: "PUT",
        position: pos 
      },
      dataType: "json"
    });
  },
  axis: "y",
  placeholder: "item"
};

var sortableListOptions = {
  update: function(ev, ui){
    var $lis     = $(this).children("li"),
        position = ($lis.length - $lis.index(ui.item) - 1);
    
    $.ajax({
      url: ui.item.attr("data-path"),
      dataType: "json",
      type: "PUT",
      data: { q: request.term }
    });
    
  },
  axis: "y"
};

var autocompleteSharingRenderItem = function(ul, item) {
  return $(item.html)
    .data( "item.autocomplete", item )
    .wrapInner("<a>")
    .appendTo(ul);
};

var autocompleteSharingOptions = {
  source: function(request, response){
    $.ajax({
      url: $("input#search_path").val(),
      dataType: "json",
      data: { q: request.term },
      success: function(data) {
        response(
          $.map(data, function(response){
            return {
              html: response.sharing_user_html,
              value: response.username
            }
          }));
      }
    });
  },
  minLength: 2,
  select: function(event, ui){
    $form = $(this).parents(".share_form form");
    if (ui.item) {
      $(this).addClass("username_valid");
      $("input.username", $form).val(ui.item.value);
    } else {
      $("input.username", $form).val("");
    }
  },
  open: function(){
    $(this).parents(".share_form form").find("input.username").val("");
  }
};

Tasklist.lists = {
  init : function() {
    var list_channel = socket.subscribe("private-list-" + $(this).attr("data-id"));

    list_channel.bind("lists-create", Tasklist.lists.create);
    list_channel.bind("lists-update", Tasklist.lists.update);
    list_channel.bind("lists-destroy", Tasklist.lists.destroy);
    list_channel.bind("lists-update_title", Tasklist.lists.update_title);

    list_channel.bind("tasks-create", Tasklist.tasks.create);
    list_channel.bind("tasks-update", Tasklist.tasks.update);
    list_channel.bind("tasks-destroy", Tasklist.tasks.destroy);
    list_channel.bind("tasks-insert_at", Tasklist.tasks.insert_at);
    list_channel.bind("tasks-toggle_close", Tasklist.tasks.toggle_close);
  },
  
  create : function(ev){
    var $list = $(ev.list_html).hide().prependTo("ol#lists").slideDown("fast");
    $list.each(Tasklist.lists.init);
    // $("#list_name").val("");
    // $(".tasks", $list).sortable(sortableTaskOptions);
    // $(this).parents("li").sortable(sortableListOptions);
    // $("input.ac_username", $list).autocomplete(autocompleteSharingOptions)
    //       .data("autocomplete")._renderItem = autocompleteSharingRenderItem;
    $("input.new_task", $list).focus();
  },
  
  destroy : function(ev){
    $("ol#lists li[data-id="+ev.list_id+"]").slideUp("fast", function(){
      $(this).remove();
    });
    
    if (ev.list_id == $("ol#tasks").attr("data-id")){
      document.location.href = "/";
    }
  },
  
  share : function(ev){
    var $list = $(".list[data-id="+ev.list_id+"]"),
        $ul   = $(".share_form ul", $list);
    $("input.ac_username", $list).val("").removeClass("username_valid");
    $(ev.user_html).hide().prependTo($ul).slideDown("fast");
    $("form.share_list input.username", $list).val("");
  },
  
  update_title : function(ev){
    $(".list[data-id="+ev.list_id+"] h2.name").text(ev.name).effect("highlight", 1000);
  }
};

$(document).bind("lists:create", Tasklist.lists.create);
$(document).bind("lists:destroy", Tasklist.lists.destroy);
$(document).bind("lists:share", Tasklist.lists.share);

$(".share_open, .share_close").live("click", function() {
  $(this).parents("li.list").find(".share_form").slideToggle("fast");
});

$("h2.name").inlineEdit({
  save: function(ev, hash){
    $.ajax({
      type: "PUT",
      dataType: "script",
      url: $(this).parents(".list").attr("data-path") + "?context=title&socket_id=" + socket_id,
      data: {
        list: { name: hash.value }
      }
    });
  },
  buttons: '',
  cancelOnBlur: true
});

// $("ul#lists").sortable(sortableListOptions);
$("ol#tasks").sortable(sortableTaskOptions);

$(".list input.ac_username").autocomplete(autocompleteSharingOptions).each(function(){
  $(this).data("autocomplete")._renderItem = autocompleteSharingRenderItem;
});



$('form.new_task').droppable({
  drop: function( event, ui ) {
    var $task           = ui.draggable,
        original_action = this.action,
        $task_input     = $(".new_task", this),
        $method_input   = $('<input />').attr({type: "hidden", name: "_method"}).val("PUT");
    
    $task.hide();
    this.action = $task.attr('data-path');
    $task_input.val($task.attr('data-task'));
    $method_input.appendTo(this);
    
    $(this).bind("ajax:loading", function(){
      this.action = original_action;
      $method_input.remove();
      $task_input.val("");
    });
  }
});

$("div.checkbox").live("click", function(e){
  if (e.target == this) {
    $("a", this).callRemote();
    return false;
  }
});

$("div.delete").live("click", function(e){
  if (e.target == this) {
    $("a", this).callRemote();
    return false;
  }
});

$("form.share_list").submit(function(){
  return ($(".username", this).val().length > 0);
});

$("#new_list").submit(function(){
  return ($("#list_name").val().length > 0);
});

// Tasks

Tasklist.tasks = {
  create : function(ev){
    $("div.new-task input").val("");
    $(ev.task_html).hide().prependTo("ol#tasks").slideDown("fast");
  },
  
  update : function(ev){
    $(ev.task_html).hide().replaceAll("li.task[data-id="+ev.task_id+"]").slideDown("fast");
  },
  
  destroy : function(ev){
    $("li.task[data-id="+ev.task_id+"]").slideUp("fast", function(){
      $(this).remove();
    });
  },
  
  insert_at : function(ev){
    var $task   = $("li.task[data-id="+ev.task_id+"]"),
        $list   = $task.parents(".tasks"),
        $tasks  = $("li", $list),
        sindex  = $tasks.index($task),
        lindex  = $tasks.length - 1,
        tindex  = lindex - ev.position,
        $target = $("li:eq("+tindex+")", $list);
    
    if (tindex > sindex && tindex > 0) {
      $task.insertAfter($target);
    } else {
      $task.insertBefore($target);
    }
  },
  
  toggle_close : function(ev){
    $("li.task[data-id="+ev.task_id+"]").slideUp("fast").remove();
    if (ev.closed == true){
      $(ev.task_html).appendTo("ul#closed-tasks").slideDown("fast");
    } else {
      $(ev.task_html).appendTo("ol#tasks").slideDown("fast");
    }
  }
};

$(document).bind("tasks:create", Tasklist.tasks.create);
$(document).bind("tasks:update", Tasklist.tasks.update);
$(document).bind("tasks:destroy", Tasklist.tasks.destroy);
$(document).bind("tasks:insert_at", Tasklist.tasks.insert_at);
$(document).bind("tasks:toggle_close", Tasklist.tasks.toggle_close);

$("#new_task").submit(function(){
  return ($("#new_task input.new_task").val().length > 0);
});

user_channel.bind("lists-create", Tasklist.lists.create);

$("ol#lists li").each(Tasklist.lists.init);
