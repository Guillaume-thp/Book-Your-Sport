module ApplicationHelper

  def incomplete_search?
    if params[:city][:choice] == "Ville" || params[:time][:choice] =="" params[:duration][:choice],params[:date])
end
