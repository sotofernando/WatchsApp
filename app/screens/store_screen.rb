class StoreScreen < PM::TableScreen  
  title "Store"
  status_bar :light
	searchable placeholder: "Search product"
  # def on_load
  # 	@tasks = []
  #   @layout = StoreLayout.new(root: self.view).build
  # end

  # def table_data
  # 	["hola", "adios"]
  # end


	def table_data
	  [{
	    # title: "ppp",
	    cells: [
	      { title: "a", action: :visit_state, arguments: { state: @a },
			    # Swipe-to-delete
		      editing_style: :delete, # (can be :delete, :insert, or :none)
		      # Moveable Cell
		      moveable: true # can also be false or :section
		      },
	      { title: "c", action: :visit_state, arguments: { state: @c },
			    # Swipe-to-delete
		      editing_style: :delete, # (can be :delete, :insert, or :none)
		      # Moveable Cell
		      moveable: true # can also be false or :section
		      }
	    ]
	  }]
	end

end
