extends Container

@onready var card = preload("res://cardHolder.tscn")
var startPosition 
var cardHighlighted = false


func _on_mouse_entered():
	$Anim.play("Select")
	cardHighlighted = true


func _on_mouse_exited():
	$Anim.play("Deselect")
	cardHighlighted = false


func _on_gui_input(event):
	if(event is InputEventMouseButton) and (event.button_index == 1):
		if event.button_mask == 1:
			#press down
			if cardHighlighted:
				var cardTemp = card.instantiate()
				get_tree().get_root().get_node("Board/CardHolder").add_child(cardTemp)
				Game.cardSelected = true
				if cardHighlighted:
					self.get_child(0).hide()
		elif event.button_mask == 0:
			#press up
			if !Game.mouseOnPlacement:
				#place card NOT on board
				cardHighlighted = false
				self.get_child(0).show()
			else:
				#place card on board
				self.queue_free()
				get_node("../../CardPlacement").placeCard()
			for i in get_tree().get_root().get_node("Board/CardHolder").get_child_count():
				#only works if the cards are same
				get_tree().get_root().get_node("Board/CardHolder").get_child(i).queue_free()
			Game.cardSelected = false
				
				
