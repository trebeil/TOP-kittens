class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
  end

  def show
    @kitten = Kitten.find(params[:id])
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      flash[:success] = "Looks like someone new is in the house! Be welcome, #{@kitten.name}!"
      redirect_to @kitten
    else
      flash[:error] = "Looks like someone doesn't know how to fill a simple form!"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      flash[:success] = "Changing is okay. We still love you, #{@kitten.name}!"
      redirect_to @kitten
    else
      flash[:error] = "Can't do that, mate!"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    flash[:success] = "No more #{@kitten.name} around here. Good bye!"
    @kitten.destroy
    redirect_to root_path
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
