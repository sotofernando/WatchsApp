class HomeScreen < PM::TableScreen
  title "Home Order"
  status_bar :light
	searchable placeholder: "Search product"
  longpressable

  def on_load
    set_nav_bar_button :right, title: "Store >", action: :open_store_screen
    set_nav_bar_button :left, title: "Add", action: :add_product
    toggle_edit_mode
  end

  def open_store_screen
    open StoreScreen
  end

  def add_product
    # puts "----fsv------"
    # mp self # HomeScreen
    # mp tableView # UITableView
    # mp tableView.contentOffset
    # mp "vc: #{tableView.visibleCells}"
    # puts "----fsv------"

    vc = tableView.visibleCells
    if vc.nil? || vc.empty?
    	index = 1
    else
	    # mp tableView.visibleCells.first.textLabel.text 
	    middle_product_name = vc[vc.size/2].textLabel.text 
			index = Product.where(name: middle_product_name).pluck(:home_order).first
		end
    # mp middle_product_name
    # mp tableView.indexPathForRowAtPoint
    # mp tableView.indexPathsForVisibleRows
    product = Product.create(name: Time.now.to_f.to_s, home_order: 0, store_order: 0)
    product.insert_new_product("home", index)
		update_table_data if product.persisted?
  end

  def table_data
    @products = Product.order("home_order ASC").find_all
    [{
      cells: @products.map do |product|
        {
          # title: product.home_order.to_s + ". " + product.name,
          title: product.name,
          editing_style: :delete, #:insert, #:none,
          moveable: true,
		      # Tap action, passed arguments
		      action: :tapped_cell,
		      long_press_action: :long_pressed_cell, # requires `longpressable`
		      # arguments: { data: [ "lots", "of", "data" ] },
          # subtitle: product.description,
          arguments: { product: product }
        }
      end
    }]
  end

	def on_cell_deleted(cell)
	  # if cell[:arguments][:some_value] == "something"
	  #   App.alert "Sorry, can't delete that row." # BubbleWrap alert
	  #   false
	  # else
	    product = Product.find(cell[:arguments][:product].id)
	    product.delete_gap("home",  product.home_order,  Product.find_all.size)
      product.delete_gap("store", product.store_order, Product.find_all.size)
      product.destroy
	    # update_table_data if product.destroy
	    true # return anything *but* false to allow deletion in the UI
      # false # I manage deleting and refreshing
	  # end
	end

	def on_cell_moved(args)
		a = args
	  mp args
	  mp from_index = args[:paths][:from].indexAtPosition(1)
	  mp to_index   = args[:paths][:to].indexAtPosition(1)
	  mp product = Product.find(args[:cell][:arguments][:product].id)
	  if from_index > to_index
		  product.create_gap("home", to_index+1, from_index)
		else
		  product.delete_gap("home", from_index+1, to_index+1)
		end
	  product.home_order = to_index+1
    # product.save
    update_table_data if product.save
		mp "moved!!!"
	end

	def long_pressed_cell(args)

    vc = tableView.visibleCells
    if vc.nil? || vc.empty?
    	# index = 1
    else
  	  puts "----fsv long_pressed_cell-----"
	    mp tableView.visibleCells
	    mp tableView.visibleCells.first
	    mp tableView.visibleCells.first.frame
	    mp tableView.visibleCells.first.frame.origin
	    mp tableView.visibleCells.first.frame.origin.y
	    puts "----fsv long_pressed_cell-----"
	    y_position = tableView.visibleCells.first.frame.origin.y + 100
	  #   middle_product_name = vc[vc.size/2].textLabel.text 
			# index = Product.where(name: middle_product_name).pluck(:home_order).first
		end

		@prod = args[:product]
    @uitf = add UITextField.new, {
      text: args[:product].name,
      frame: CGRectMake(10, y_position, 300, 40),
      # tint_color: UIColor.whiteColor,
      text_color: UIColor.whiteColor,
      # color: UIColor.whiteColor,
      background_color: UIColor.blackColor
    }
    # add @uitf
    @uitf.delegate = self
    mp @uitf
    mp @uitf.class
    mp @uitf.delegate
		# @input = UITextInput.new
		# add @input
		# toggle_edit_mode
		mp "longpressable!!!"
	end

  def textFieldShouldReturn(textfield)
    textfield.resignFirstResponder
    puts "----fsv tf-----"
    mp textfield
    puts "----fsv tf-----"
    product = Product.find(@prod.id)
    product.name = textfield.text
    update_table_data if product.save
    remove @uitf
    true
  end

	def tapped_cell
		mp "tocado!"
		
	end

end

