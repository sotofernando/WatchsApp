class Product < MotionRecord::Base
  # That's all!
  def insert_new_product(list, index)
  	number_of_products = Product.find_all.size
  	home_index  = number_of_products
  	store_index = number_of_products
  	case list
  	when "home"
  		home_index = index
  	when "store"
  		store_index = index
  	else
  		raise "list must be home or store!!!"
  	end
  	create_gap(list, index, number_of_products)
    # product = Product.new(name: Time.now.to_s, home_order: home_index, store_order: store_index) #"NUEVO PRODUCTO"
    self.home_order  = home_index
    self.store_order = store_index
    self.name = "PRODUCT #{self.id.to_s}"
    self.save
  end


	def create_gap(list, index, to_index)
		Product.find_all.each do |p|
			if list.eql?("home")
				if p.home_order >= index && p.home_order <= to_index
					p.home_order = p.home_order + 1
					p.save
				end
			elsif list.eql?("store")
        if p.store_order >= index && p.store_order <= to_index
          p.store_order = p.store_order + 1
          p.save
        end
			end
		end
	end

	def delete_gap(list, index, to_index)
		Product.find_all.each do |p|
			if list.eql?("home")
				if p.home_order > index && p.home_order <= to_index
					p.home_order = p.home_order - 1
					p.save
				end
			elsif list.eql?("store")
        if p.store_order > index && p.store_order <= to_index
          p.store_order = p.store_order - 1
          p.save
        end
			end
		end
	end


end