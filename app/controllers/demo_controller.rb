class DemoController < ApplicationController
  def index
  end
  def show
    redirect_to ({:controler => "demo", :action => "index"})
  end
end
