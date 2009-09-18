# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  WIKIROOT = "http://wiki.github.com/"

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  def pagetitle
    "%s - %s" % [self.class.name.chomp("Controller"), action_name]
  end

  private

  def github_wikipage_url(opts)
    "#{WIKIROOT}#{opts[:user]}/#{opts[:repo]}/#{opts[:page]}" + 
      (opts[:version] ? "/#{opts[:version]}" : "")
  end

  def github_wikipage_edit_url(opts)
    opts = opts.dup
    opts.delete(:version)
    github_wikipage_url(opts) + "/edit"
  end
end
