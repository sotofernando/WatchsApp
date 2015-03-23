class HomeScreen < PM::TableScreen
  title "Home"
  status_bar :light
	searchable placeholder: "Search product"
  longpressable

  def on_load
    set_nav_bar_button :left, title: "Store", action: :open_store_screen
    set_nav_bar_button :right, title: "Add", action: :add_product
    # open StoreScreen
  end

  def open_store_screen
    open StoreScreen
  end

  def add_product
    puts "----fsv------"
    ap self # HomeScreen
    ap tableView # UITableView
    ap tableView.contentOffset
    ap "vc: #{tableView.visibleCells}"
    puts "----fsv------"

    vc = tableView.visibleCells
    if vc.nil? || vc.empty?
    	home_index = 1
    else
	    ap tableView.visibleCells.first.textLabel.text 
	    middle_product_name = vc[vc.size/2].textLabel.text 
			home_index = Product.where(name: middle_product_name).pluck(:home_order).first
		end
    ap middle_product_name
    # ap tableView.indexPathForRowAtPoint
    # ap tableView.indexPathsForVisibleRows
    product = Product.create(name: Time.now.to_f.to_s, home_order: 0, store_order: 0)
    product.insert_new_product("home", home_index)
    # product = Product.new(name: Time.now.to_s, home_order: home_index+1, store_order: 1) #"NUEVO PRODUCTO"
    # product.save
    # sleep 0.5
		update_table_data if product.persisted?
  end

  def table_data
    @products = Product.order("home_order ASC").find_all
    [{
      cells: @products.map do |product|
        {
          title: product.name,
          editing_style: :delete, #:insert, #:none,
          moveable: true,
		      # Tap action, passed arguments
		      action: :tapped_cell,
		      long_press_action: :long_pressed_cell, # requires `longpressable`
		      # arguments: { data: [ "lots", "of", "data" ] },
          # subtitle: product.description,
          arguments: { id: product.id }
        }
      end
    }]
  end

	def on_cell_deleted(cell)
	  # if cell[:arguments][:some_value] == "something"
	  #   App.alert "Sorry, can't delete that row." # BubbleWrap alert
	  #   false
	  # else
	    product = Product.find(cell[:arguments][:id])
	    product.delete_gap("home", product.home_order, Product.find_all.size)
	    product.destroy
	    true # return anything *but* false to allow deletion in the UI
	  # end
	end

	def on_cell_moved(args)
		a = args
		ap "moved!!!"
	  ap args
	  ap from_index = args[:paths][:from].indexAtPosition(1)
	  ap to_index   = args[:paths][:to].indexAtPosition(1)
	  ap product = Product.find(args[:cell][:arguments][:id])
	  if from_index > to_index
		  product.create_gap("home", to_index+1, from_index)
		else
		  product.delete_gap("home", from_index+1, to_index+1)
		end
	  product.home_order = to_index+1
	  product.save
	  ap "debug fsv"
	end

	def long_pressed_cell
		toggle_edit_mode
		ap "longpressable!!!"
	end

	def tapped_cell
		ap "tocado!"
		
	end

	# def table_data
	#   [{
	#     # title: "ppp",
	#     cells: [
	#       { title: "a", action: :visit_state, arguments: { state: @a },
	# 		    # Swipe-to-delete
	# 	      editing_style: :delete, # (can be :delete, :insert, or :none)
	# 	      # Moveable Cell
	# 	      moveable: true # can also be false or :section
	# 	      },
	#       { title: "b", action: :visit_state, arguments: { state: @b },
	# 		    # Swipe-to-delete
	# 	      editing_style: :delete, # (can be :delete, :insert, or :none)
	# 	      # Moveable Cell
	# 	      moveable: true # can also be false or :section
	# 	      },
	#       { title: "c", action: :visit_state, arguments: { state: @c },
	# 		    # Swipe-to-delete
	# 	      editing_style: :delete, # (can be :delete, :insert, or :none)
	# 	      # Moveable Cell
	# 	      moveable: true # can also be false or :section
	# 	      }
	#     ]
	#   }]
	# end

end

