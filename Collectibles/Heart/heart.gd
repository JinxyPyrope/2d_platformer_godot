extends Area2D

#This is body entered not area entered because our player isnts a "Area2D" node it's a "BOdy Node"
func _on_body_entered(_body):
	queue_free()
	#This function is connected to a group making us keep track of how many collecitbles we have gotten since the var ia also an array
	var hearts = get_tree().get_nodes_in_group("Hearts")
	#The "size" function is a built in function for arrays in this case its' hearts
	if hearts.size() == 1:
		#This will get the global signal we made for "level_completed in the Project Settings autoload to activate once alll collecitbales are taken
		Events.level_completed.emit()
		
