module TaskHelper
  def link_class(task)
    task.closed? ? "closed" : nil
  end
end