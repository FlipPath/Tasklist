class ListsController < ApplicationController
  def create
    @list = List.create(:name => params[:list][:name])
    
    respond_to do |format|
      format.js
    end
  end
  
end