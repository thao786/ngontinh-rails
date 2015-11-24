class WelcomeController < ApplicationController
  def index
    @first6en = Fiction.where(language: "en").limit(6)
    @first6vn = Fiction.where(language: "vn").limit(6)
    @random = Fiction.order("RANDOM()").limit(6)
  end

  def all

  end

  def vn

  end
end
