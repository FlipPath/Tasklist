module ListHelper
  def selected_class(list, current_list)
    list.id == current_list.id ? "selected" : nil
  end
end