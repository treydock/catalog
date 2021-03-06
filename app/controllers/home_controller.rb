class HomeController < ApplicationController
	def index
		@query_params = QueryFormat.catalog_format()
		@autocomplete_params = QueryFormat.autocomplete_format()
		@names_params = QueryFormat.names_format()
		@uri_params= {'uri' => {:name => 'URI', :description => 'The URI of the object that you are interested in.'}}
		@locals_params = QueryFormat.locals_format()

		if request.post?
			render :partial => 'tabs'
		end
	end
end
