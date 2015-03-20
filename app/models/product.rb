class Product < MotionRecord::Base
  # That's all!
  def inserta(list, index)
  	number_of_products = Product.find_all.size
  	home_index  = number_of_products + 1
  	store_index = number_of_products + 1
  	case list
  	when "home"
  		home_index = index
  	when "store"
  		store_index = index
  	else
  		raise "list debe ser home o store!!!"
  	end
  	create_gap(list, index)
    # product = Product.new(name: Time.now.to_s, home_order: home_index, store_order: store_index) #"NUEVO PRODUCTO"
    self.home_order  = home_index
    self.store_order = store_index
    self.save
  end


	def create_gap(list, index)
		Product.find_all.each do |p|
			if list.eql?("home")
				if p.home_order >= index
					p.home_order = p.home_order + 1
					p.save
				end
			elsif list.eql?("store")
				raise "FALTA CODIGO ----------------------------------------------"
			end
		end
	end

	def delete_gap(list_order, index)
		Product.where('#{list_order} >  ?', index).update_all("#{list_order} = #{list_order} - 1")
	end


end