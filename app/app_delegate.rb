# class AppDelegate < PM::Delegate
#   status_bar true, animation: :none

#   # def on_load(app, options)
#   #   return true if RUBYMOTION_ENV == "test"
#   #   open HomeScreen.new(nav_bar: true)
#   # end
#   def on_load(app, options)
#     @tab_1 = HomeScreen.new(nav_bar: true)
#     @tab_2 = SuperScreen.new(nav_bar: true)
#     # @tab_3 = ProductsScreen.new

#     @tab_bar = open_tab_bar @tab_1, @tab_2#, @tab_3
#   end
# end

class AppDelegate < PM::Delegate
  status_bar true, animation: :fade

  def on_load(app, options)

	  MotionRecord::Schema.up! do
	    migration 1, "Create products table" do
	      create_table :products do |t|
	        t.text    :name,      null: false
	        t.integer :home_order
	        t.integer :store_order
	        t.integer :status, default: 0
	      end
	    end
	    migration 2, "unique product name" do
	      add_index :products, :name, :unique => true
	    end
	  end



    product = Product.new(name: "Chorizo", home_order: 1, store_order: 1)
    #product.save!
    # puts product.persisted?
    # puts product.id
    # puts product.name
    # puts product.status

    open HomeScreen.new(nav_bar: true)
  end
end