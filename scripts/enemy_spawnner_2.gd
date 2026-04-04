extends Node2D

@export var enemy_scene: PackedScene = preload("res://scenes/enemy_orange_cat.tscn")
@export var spawn_direction: int = 1

func _on_timer_timeout() -> void:
	var enemy_instance = enemy_scene.instantiate()
	
	# Set position
	enemy_instance.global_position = global_position
	
	# Pass the direction to the cat BEFORE it enters the scene
	if "direction" in enemy_instance:
		enemy_instance.direction = spawn_direction
	
	# Add to the game
	get_tree().current_scene.add_child(enemy_instance)
