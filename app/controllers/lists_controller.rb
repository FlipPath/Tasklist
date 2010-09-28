class ListsController < ApplicationController
  def create
    @list = List.create(:name => params[:list][:name])
    
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @list = List.find(params[:id])
    @list.destroy
    
    respond_to do |format|
      format.js
    end
  end
end