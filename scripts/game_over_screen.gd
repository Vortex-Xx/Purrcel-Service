extends CanvasLayer

func _on_restart_button_pressed() -> void:
	# 1. Unpause the game so the player can move
	get_tree().paused = false
	
	# 2. Restart the current level
	get_tree().reload_current_scene()
	
	# 3. Hide the Game Over screen
	self.hide()
