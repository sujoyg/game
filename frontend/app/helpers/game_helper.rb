module GameHelper
  def get_score
    session[:score] ||= 0
  end

  def reset_game
    session.delete :score
    session.delete :hit
  end

  def record_a_hit
    session[:hit] = true
    session[:score] ||= 0
    session[:score] = session[:score] + 1
  end

  def record_a_miss
    session[:hit] = false
  end
end
