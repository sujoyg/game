module GameHelper
  def get_score
    session[:score] ||= 0
  end

  def reset_game
    session.delete :score
    session.delete :hit
  end

  def increase_score
    session[:score] ||= 0
    session[:score] = session[:score] + 1
  end
end
