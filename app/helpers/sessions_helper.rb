module SessionsHelper

  def set_recipe(id)
    session[:recipe_id] = id
  end
end
