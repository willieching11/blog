module SitesHelper
	def title(page_title, show_title= true)
		content_for(:title) {page_title.to_s }
		@show_title = show_title
	end

	def show_title?
		@show_title
	end
	
	def nav_link(text,path)
    if current_page?(path)
      content_tag :li, link_to(text, path), class: 'active'
    else
      content_tag :li, link_to(text, path)
    end
  end
end
