module GameHelper
  def get_score
    session[:score] ||= 0
  end

  def get_rounds
    session[:rounds] ||= 0
  end

  def reset_game
    session.delete :score
    session.delete :hit
    session.delete :rounds
  end

  def set_result(hit)
    increase_score if hit
    increase_round
  end

  def increase_score
    session[:score] ||= 0
    session[:score] = session[:score] + 1
  end

  def increase_round
    session[:rounds] ||= 0
    session[:rounds] = session[:rounds] + 1
  end
end
