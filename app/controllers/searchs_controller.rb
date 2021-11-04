class SearchsController < ApplicationController

  def search
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    @records = search_for(@model, @content, @method)
  end

  private
  def search_for(model, content, method)

    if model == 'user'
      if method == "forword"
        User.where("name LIKE?","#{content}%")
      elsif method == "backword"
        User.where("name LIKE?","%#{content}")
      elsif method == "perfect"
        User.where(name: content)
      elsif method == "partial"
        User.where("name LIKE?","%#{content}%")
      else
        User.all
      end
      
    elsif model == 'book'
      if method == "forword"
        Book.where("title LIKE?", "#{content}%")
      elsif method == "backword"
        Book.where("title LIKE?", "%#{content}")
      elsif method == "perfect"
        Book.where(title: content)
      elsif method == "partial"
        Book.where("title LIKE?", "%#{content}%")
      else
        Book.all
      end
    end
  end

end

