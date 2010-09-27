var Tasklist = { };

Tasklist.tasks = {
  create : function(ev) {
    $("#task_task").val("");
    $(ev.taskHtml).prependTo("ul");
  },
  
  complete : function(ev) {
    $("div.task[data-id="+ev.taskId+"]").html(ev.taskHtml);
  },
  
  destroy : function(ev) {
    $("div.task[data-id="+ev.taskId+"]").parents("li").slideUp("fast", function(){
      $(this).remove();
    });
  }
};

$(document).bind("tasks:create", Tasklist.tasks.create);
$(document).bind("tasks:complete", Tasklist.tasks.complete);
$(document).bind("tasks:destroy", Tasklist.tasks.destroy);

$("#task_task").focus();
$("#new_task").submit(function(){
  return ($("#task_task").val().length > 0);
});