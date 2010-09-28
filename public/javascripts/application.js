var Tasklist = { };

// Lists

Tasklist.lists = {
  create : function(ev) {
    $("#list_name").val("");
    $(ev.listHtml).prependTo("#list_list");
    $("#"+ev.listId+"_task_task").focus();
  },
  
  destroy : function(ev) {
    $(".list[data-id="+ev.listId+"]").slideUp("fast", function(){
      $(this).remove();
    });
  }
};

$(document).bind("lists:create", Tasklist.lists.create);
$(document).bind("lists:destroy", Tasklist.lists.destroy);

$("#list_name").focus();

// Tasks

Tasklist.tasks = {
  create : function(ev) {
    $("#"+ev.listId+"_task_task").val("");
    $(ev.taskHtml).prependTo(".list[data-id="+ev.listId+"] .tasks");
  },
  
  complete : function(ev) {
    $(".task[data-id="+ev.taskId+"]").html(ev.taskHtml);
  },
  
  destroy : function(ev) {
    $(".task[data-id="+ev.taskId+"]").parents("li").slideUp("fast", function(){
      $(this).remove();
    });
  }
};

$(document).bind("tasks:create", Tasklist.tasks.create);
$(document).bind("tasks:complete", Tasklist.tasks.complete);
$(document).bind("tasks:destroy", Tasklist.tasks.destroy);

// $("#task_task").focus();
$("#new_task").submit(function(){
  return ($("#task_task").val().length > 0);
});