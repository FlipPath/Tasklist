module ListHelper
  def selected_class(list, list_id)
    list.id == list_id ? "selected" : nil
  end
end