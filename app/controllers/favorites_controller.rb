class FavoritesController < ApplicationController
  def index
    @q = Favorite.ransack(params[:q])
    @favorites = @q.result(:distinct => true).includes(:user, :recipes, :cuisine).page(params[:page]).per(10)

    render("favorite_templates/index.html.erb")
  end

  def show
    @favorite = Favorite.find(params.fetch("id_to_display"))

    render("favorite_templates/show.html.erb")
  end

  def new_form
    @favorite = Favorite.new

    render("favorite_templates/new_form.html.erb")
  end

  def create_row
    @favorite = Favorite.new

    @favorite.recipes_id = params.fetch("recipes_id")
    @favorite.user_id = params.fetch("user_id")
    @favorite.cuisine_id = params.fetch("cuisine_id")

    if @favorite.valid?
      @favorite.save

      redirect_back(:fallback_location => "/favorites", :notice => "Favorite created successfully.")
    else
      render("favorite_templates/new_form_with_errors.html.erb")
    end
  end

  def create_row_from_recipe
    @favorite = Favorite.new

    @favorite.recipes_id = params.fetch("recipes_id")
    @favorite.user_id = params.fetch("user_id")
    @favorite.cuisine_id = params.fetch("cuisine_id")

    if @favorite.valid?
      @favorite.save

      redirect_to("/recipes/#{@favorite.recipes_id}", notice: "Favorite created successfully.")
    else
      render("favorite_templates/new_form_with_errors.html.erb")
    end
  end

  def create_row_from_cuisine
    @favorite = Favorite.new

    @favorite.recipes_id = params.fetch("recipes_id")
    @favorite.user_id = params.fetch("user_id")
    @favorite.cuisine_id = params.fetch("cuisine_id")

    if @favorite.valid?
      @favorite.save

      redirect_to("/cuisines/#{@favorite.cuisine_id}", notice: "Favorite created successfully.")
    else
      render("favorite_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @favorite = Favorite.find(params.fetch("prefill_with_id"))

    render("favorite_templates/edit_form.html.erb")
  end

  def update_row
    @favorite = Favorite.find(params.fetch("id_to_modify"))

    @favorite.recipes_id = params.fetch("recipes_id")
    @favorite.user_id = params.fetch("user_id")
    @favorite.cuisine_id = params.fetch("cuisine_id")

    if @favorite.valid?
      @favorite.save

      redirect_to("/favorites/#{@favorite.id}", :notice => "Favorite updated successfully.")
    else
      render("favorite_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row_from_user
    @favorite = Favorite.find(params.fetch("id_to_remove"))

    @favorite.destroy

    redirect_to("/users/#{@favorite.user_id}", notice: "Favorite deleted successfully.")
  end

  def destroy_row_from_recipes
    @favorite = Favorite.find(params.fetch("id_to_remove"))

    @favorite.destroy

    redirect_to("/recipes/#{@favorite.recipes_id}", notice: "Favorite deleted successfully.")
  end

  def destroy_row_from_cuisine
    @favorite = Favorite.find(params.fetch("id_to_remove"))

    @favorite.destroy

    redirect_to("/cuisines/#{@favorite.cuisine_id}", notice: "Favorite deleted successfully.")
  end

  def destroy_row
    @favorite = Favorite.find(params.fetch("id_to_remove"))

    @favorite.destroy

    redirect_to("/favorites", :notice => "Favorite deleted successfully.")
  end
end
