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

    open @hs = HomeScreen.new(nav_bar: true)
  end
end