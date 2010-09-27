var Tasklist = { };

Tasklist.tasks = {
  create : function(ev) {
    $("#task_task").val("");
    $(ev.taskHtml).prependTo("ul");
  },
  
  complete : function(ev) {
    $("#task_list li a[data-id="+ev.taskId+"]").html(ev.taskHtml);
  }
};

$(document).bind("tasks:create", Tasklist.tasks.create);
$(document).bind("tasks:complete", Tasklist.tasks.complete);

$("#task_task").focus();
$("#new_task").submit(function(){
  return ($("#task_task").val().length > 0);
});