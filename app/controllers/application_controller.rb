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

  # opts[:version].nil?  -> fetch most recent version
  # opts[:version] == -1 -> fetch most recent version
  def github_wikipage_url(opts)
    ver = case opts[:version]
          when nil, -1:
              nil
          when Integer:
              opts[:version]
          else
            raise "Invalid version: #{opts[:version].inspect}."
          end
    "#{WIKIROOT}#{opts[:user]}/#{opts[:repo]}/#{opts[:page]}" + 
      (ver ? "/#{ver}" : "")
  end

  def github_wikipage_edit_url(opts)
    opts = opts.dup
    opts.delete(:version)
    github_wikipage_url(opts) + "/edit"
  end
end
