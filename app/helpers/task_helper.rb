module TaskHelper
  def closed_class(task)
    task.closed? ? "closed" : nil
  end
end