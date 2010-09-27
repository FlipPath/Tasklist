module TaskLinkClassHelper
  def link_class(task)
    task.completed? ? "completed" : nil
  end
end