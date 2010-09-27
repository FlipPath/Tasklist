var Tasklist = { };

Tasklist.tasks = {
  create : function(ev) {
    $("#task_task").val("");
    $(ev.taskHtml).prependTo("ul");
  }
};

$(document).bind("tasks:create", Tasklist.tasks.create);

$("#task_task").focus();
$("#new_task").submit(function(){
  return ($("#task_task").val().length > 0);
});