class RecipesController < ApplicationController
  before_action :current_user_must_be_recipe_user, :only => [:edit_form, :update_row, :destroy_row]

  def current_user_must_be_recipe_user
    recipe = Recipe.find(params["id_to_display"] || params["prefill_with_id"] || params["id_to_modify"] || params["id_to_remove"])

    unless current_user == recipe.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @recipes = Recipe.page(params[:page]).per(10)

    render("recipe_templates/index.html.erb")
  end

  def show
    @favorite = Favorite.new
    @recipe = Recipe.find(params.fetch("id_to_display"))

    render("recipe_templates/show.html.erb")
  end

  def new_form
    @recipe = Recipe.new

    render("recipe_templates/new_form.html.erb")
  end

  def create_row
    @recipe = Recipe.new

    @recipe.user_id = params.fetch("user_id")
    @recipe.cuisine_id = params.fetch("cuisine_id")
    @recipe.ingredients = params.fetch("ingredients")
    @recipe.directions = params.fetch("directions")
    @recipe.country_origin = params.fetch("country_origin")
    @recipe.name = params.fetch("name")
    @recipe.photo = params.fetch("photo")

    if @recipe.valid?
      @recipe.save

      redirect_back(:fallback_location => "/recipes", :notice => "Recipe created successfully.")
    else
      render("recipe_templates/new_form_with_errors.html.erb")
    end
  end

  def create_row_from_cuisine
    @recipe = Recipe.new

    @recipe.user_id = params.fetch("user_id")
    @recipe.cuisine_id = params.fetch("cuisine_id")
    @recipe.ingredients = params.fetch("ingredients")
    @recipe.directions = params.fetch("directions")
    @recipe.country_origin = params.fetch("country_origin")
    @recipe.name = params.fetch("name")
    @recipe.photo = params.fetch("photo")

    if @recipe.valid?
      @recipe.save

      redirect_to("/cuisines/#{@recipe.cuisine_id}", notice: "Recipe created successfully.")
    else
      render("recipe_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @recipe = Recipe.find(params.fetch("prefill_with_id"))

    render("recipe_templates/edit_form.html.erb")
  end

  def update_row
    @recipe = Recipe.find(params.fetch("id_to_modify"))

    
    @recipe.cuisine_id = params.fetch("cuisine_id")
    @recipe.ingredients = params.fetch("ingredients")
    @recipe.directions = params.fetch("directions")
    @recipe.country_origin = params.fetch("country_origin")
    @recipe.name = params.fetch("name")
    @recipe.photo = params.fetch("photo")

    if @recipe.valid?
      @recipe.save

      redirect_to("/recipes/#{@recipe.id}", :notice => "Recipe updated successfully.")
    else
      render("recipe_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row_from_user
    @recipe = Recipe.find(params.fetch("id_to_remove"))

    @recipe.destroy

    redirect_to("/users/#{@recipe.user_id}", notice: "Recipe deleted successfully.")
  end

  def destroy_row_from_cuisine
    @recipe = Recipe.find(params.fetch("id_to_remove"))

    @recipe.destroy

    redirect_to("/cuisines/#{@recipe.cuisine_id}", notice: "Recipe deleted successfully.")
  end

  def destroy_row
    @recipe = Recipe.find(params.fetch("id_to_remove"))

    @recipe.destroy

    redirect_to("/recipes", :notice => "Recipe deleted successfully.")
  end
end
