module GameHelper
  def get_score
    session[:score] ||= 0
  end

  def get_rounds
    session[:rounds] ||= 0
  end

  def set_current_round(person)
    session[:person_id] = person.id
    session[:name] = person.name
    session[:email] = person.email
    session[:image] = person.image
    session[:waiting] = true
  end

  def get_last_round
    [session[:hit], session[:name], session[:guess], session[:email]]
  end

  def reset_game
    session.delete :score
    session.delete :hit
    session.delete :rounds
    session.delete :name
    session.delete :guess
    session.delete :email
    session.delete :hit
    session.delete :image
    session.delete :waiting
    session.delete :person_id
  end

  def set_result(person, guess)
    hit = person.name.downcase == guess
    increase_score if hit
    increase_round

    session[:person_id] = person.id
    session[:name] = person.name
    session[:guess] = guess
    session[:email] = person.email
    session[:hit] = hit
    session[:waiting] = false
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
