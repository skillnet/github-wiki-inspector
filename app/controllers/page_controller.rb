require 'hpricot'

class PageController < ApplicationController
  def show
    @page_content = fetch_page_content
    @page_versions_select = fetch_page_versions_select
    @page_max_version = fetch_page_max_version
  end

  def diff
    @v1 = params[:versions_select].to_i
    @page1 = fetch_page_content(@v1)
    @page_max_version = fetch_page_max_version
    @v2 = @page_max_version
    @v2 = @v1 - 1 if @v1 > 0
    @page2 = fetch_page_content(@v2)
    @diff = HTMLDiff.diff(@page2, @page1)
    @page_versions_select = fetch_page_versions_select
    @show_current_url = github_wikipage_url(params.merge :version => nil)
  end

  def pagetitle
    "Page - #{fetch_page_title} - #{action_name}"
  end

  private

  def normalize_version(version = nil)
    case version
    when nil, 0
      nil
    when :any
      @page.keys.first
    else
      version.to_i
    end
  end

  def page_url(version = nil)
    @page_url ||= Hash.new
    version = normalize_version(version)
    @page_url[version] ||= github_wikipage_url(params.merge :version => version)
  end

  def page(version = nil)
    @page ||= Hash.new
    version = normalize_version(version)
    @page[version] ||= 
      Hpricot(Net::HTTP.get_response(URI.parse(page_url(version))).body)
  end

  def fetch_elem(version = nil, html = true, &block)
    elem = yield(page(version))
    html ? elem.inner_html : elem
  end

  def fetch_page_content(version = nil, html = true)
    fetch_elem(version, html) do |doc|
      doc.at("div.main")
    end
  end

  def fetch_page_title(version = nil, html = true)
    fetch_elem(version, html) do |doc|
      doc.at("div.main>h1")
    end
  end

  def fetch_page_versions_select(html = true)
    elem = fetch_elem(:any, false) do |doc|
      doc.at("#versions_select")
    end
    elem.children.each do |e|
      e['value'] = (e['value'].match('([0-9]+)$')[0].to_i rescue 0).to_s
    end
    html ? elem.to_html : elem
  end

  def fetch_page_max_version
    fetch_page_versions_select(false).children.map do |s| 
      s['value'].to_i rescue 0 
    end.max
  end
end
