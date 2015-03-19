class HomeScreen < PM::TableScreen
  title "Home"
  status_bar :light
	searchable placeholder: "Search product"

  def on_load
    set_nav_bar_button :left, title: "Store", action: :open_store_screen
    set_nav_bar_button :right, title: "+", action: :add_product
    # open StoreScreen
  end

  def open_store_screen
    open StoreScreen
  end

  def add_product
    product = Product.new(name: Time.now.to_s, home_order: 1, store_order: 1)
    product.save!
    sleep 0.5
		update_table_data if product.persisted?
  end

  def table_data
    @products = Product.find_all
    [{
      cells: @products.map do |product|
        {
          title: product.name,
          editing_style: :delete,
          moveable: true,
          # subtitle: product.description,
          # action: :edit_product,
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
	    Product.find(cell[:arguments][:id]).delete!
	    true # return anything *but* false to allow deletion in the UI
	  # end
	end

	def on_cell_moved(args)
	  # Do something here
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

