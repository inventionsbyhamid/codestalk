class PagesController < ApplicationController
  def index
  	@codechef_ids = Handle.order("created_at DESC").limit(2)
  end

  def about
  end
end
