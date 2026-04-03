extends CanvasLayer

func _on_restart_button_pressed() -> void:
	# This restarts the current scene
	get_tree().reload_current_scene()

func _on_button_pressed() -> void:
	pass # Replace with function body.
	get_tree().reload_current_scene()
