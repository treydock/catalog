class Archive < ActiveRecord::Base
	has_attached_file :carousel_image,
                    :styles => { :normal => '300x300' },
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename"
                    # to create a cropped image, use :thumb=> "100x100#".
  has_and_belongs_to_many :carousels
  attr_accessor :carousel_list
	attr_accessible :carousel_description, :typ, :name, :parent_id, :handle, :site_url, :thumbnail

	def self.get_tree()
		nodes = Archive.find_all_by_typ('node')
		nodes = nodes.map {|node|
			{ :id => node.id, :parent_id => node.parent_id, :name => node.name, :carousel_include => node.carousel_include, :carousel_description => node.carousel_description, :children => [], :sites => [] }
		}
		root = { :id => 0, :name => 'root', :children => [], :sites => []}

		nodes.each { |node|
			if node[:parent_id] == 0
				root[:children].push(node)
			else
				nodes.each { |node2|
					if node[:parent_id] == node2[:id]
						node2[:children].push(node)
						break
					end
				}
			end
		}

		archives = Archive.find_all_by_typ('archive')
		archives.each { |archive|
			if archive[:parent_id] == root[:id]
				root[:sites].push(archive)
			else
				nodes.each { |node2|
					if archive[:parent_id] == node2[:id]
						node2[:sites].push(archive)
						break
					end
				}
			end
		}

		return root
	end

	def self.compare_to_solr(solr)
		actual = solr.get_archive_list()
		archives = Archive.find_all_by_typ('archive')
		archives = archives.map { |archive| archive['handle'] }
		extra = (actual | archives) - actual
		extra = extra.map {|site| { :handle => site, :name => Archive.find_by_handle(site).name, :id => Archive.find_by_handle(site).id } }
		return { :missing => (actual | archives) - archives, :extra => extra }
	end

	def self.get_inaccessible_sites()
		inaccessible_sites = []
		nodes = Archive.find_all_by_typ('node')
		archives = Archive.find_all_by_typ('archive')
		archives.each { |node|
			archive = node
			while node.parent_id != 0 # parent id of 0 is accessible
				node = nodes.select {|n| n[:id] == node.parent_id }
				node = node[0] if node.length > 0
				if node == []
					inaccessible_sites.push(archive)
					break
				elsif node.parent_id != 0
					node = nodes.select {|n| n[:id] == node.parent_id }
					node = node[0] if node.length > 0
					if node == []
						inaccessible_sites.push(archive)
						break
					end
				end
			end
		}
		return inaccessible_sites
	end

	def self.get_category_list
		nodes = Archive.find_all_by_typ('node')
		nodes = nodes.sort { |a, b| a['name'] <=> b['name'] }
		nodes = nodes.map { |node| {:name => node['name'], :value => node['id']} }
		nodes.unshift({:name => "[root]", :value => 0})
		return nodes
  end

end
