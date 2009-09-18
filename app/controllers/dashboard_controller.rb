class DashboardController < ApplicationController
  def index
  end

  def open_page
    if m = params[:page_url].match(WIKIROOT+'([^/]+)/([^/]+)/([^/]+)')
      url, user, repo, page, version = *m
      redirect_to :controller => "page", :action => "show", :user => user, :repo => repo, :page => page
      return
    end
    flash.now[:notice] = "URL must match http://wiki.github.com/user/repo/page[/version]"
    render :action => "index"
  end
end
