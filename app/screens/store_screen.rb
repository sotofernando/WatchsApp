class StoreScreen < PM::TableScreen  
  title "Store Order"
  status_bar :light
	searchable placeholder: "Search product"
  longpressable

  def on_load
    set_nav_bar_button :right, title: "Home >", action: :open_home_screen
    set_nav_bar_button :left, title: "Add", action: :add_product
    toggle_edit_mode
  end

  def open_home_screen
    open HomeScreen
  end

  def add_product
    # puts "----fsv------"
    # ap self # StoreScreen
    # ap tableView # UITableView
    # ap tableView.contentOffset
    # ap "vc: #{tableView.visibleCells}"
    # puts "----fsv------"

    vc = tableView.visibleCells
    if vc.nil? || vc.empty?
      index = 1
    else
  	  puts "---- cell ini ------"
      ap tableView.visibleCells
      ap tableView.visibleCells.first
      ap tableView.visibleCells.first.textLabel
      ap tableView.visibleCells.first.textLabel.text 
      # ap tableView.visibleCells.first.cell_identifier 
      # ap tableView.visibleCells.first.cell_identifier.text 
	    puts "---- cell fin ------"
      middle_product_name = vc[vc.size/2].textLabel.text 
      index = Product.where(name: middle_product_name).pluck(:store_order).first
    end
    # ap middle_product_name
    # ap tableView.indexPathForRowAtPoint
    # ap tableView.indexPathsForVisibleRows
    product = Product.create(name: Time.now.to_f.to_s, home_order: 0, store_order: 0)
    product.insert_new_product("store", index)
    update_table_data if product.persisted?
  end

  def table_data
    @products = Product.order("store_order ASC").find_all
    [{
      cells: @products.map do |product|
        {
          # title: product.store_order.to_s + ". " + product.name,
          # subtitle: product.store_order.to_s,
          title: product.name,
          # cell_identifier: product.id.to_s,
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
    ap "moved!!!"
    ap args
    ap from_index = args[:paths][:from].indexAtPosition(1)
    ap to_index   = args[:paths][:to].indexAtPosition(1)
    ap product = Product.find(args[:cell][:arguments][:id])
    if from_index > to_index
      product.create_gap("store", to_index+1, from_index)
    else
      product.delete_gap("store", from_index+1, to_index+1)
    end
    product.store_order = to_index+1
    # product.save
    update_table_data if product.save
		ap "moved!!!"
  end

  def long_pressed_cell
    # toggle_edit_mode
    ap "longpressable!!!"
  end

  def tapped_cell
    ap "tocado!"
    
  end

end

