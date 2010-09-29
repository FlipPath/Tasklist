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

Tasklist.lists = {
  create : function(ev) {
    $("#list_name").val("");
    $(ev.listHtml).prependTo("#list_list").find(".tasks").sortable(sortableTaskListOptions);
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
$("ul.tasks").sortable(sortableTaskListOptions);

// Tasks

Tasklist.tasks = {
  create : function(ev) {
    $("#"+ev.listId+"_task_task").val("");
    $(ev.taskHtml).prependTo(".list[data-id="+ev.listId+"] .tasks");
  },
  
  complete : function(ev) {
    $(".task[data-id="+ev.taskId+"]").replaceWith(ev.taskHtml);
  },
  
  destroy : function(ev) {
    $(".task[data-id="+ev.taskId+"]").slideUp("fast", function(){
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