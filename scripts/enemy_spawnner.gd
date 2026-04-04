extends Node2D

# 1. This creates a list in the Inspector where you can drag multiple .tscn files
@export var enemy_scenes: Array[PackedScene] = []

func _on_timer_timeout() -> void:
	if enemy_scenes.size() == 0:
		return # Don't do anything if the list is empty
	
	# 2. Pick a random number between 0 and the size of your list
	var random_index = randi() % enemy_scenes.size()
	var selected_scene = enemy_scenes[random_index]
	
	# 3. Create the cat copy
	var enemy_instance = selected_scene.instantiate()
	
	# 4. Set position and add to scene
	enemy_instance.global_position = global_position
	get_tree().current_scene.add_child(enemy_instance)
