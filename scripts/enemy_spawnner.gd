extends Node2D

# 1. Drag your enemy .tscn file here from the FileSystem
@export var enemy_scene: PackedScene = preload("res://scenes/enemy_black_cat.tscn")

func _on_timer_timeout() -> void:
	# 2. Create a new copy of the enemy
	var enemy_instance = enemy_scene.instantiate()
	
	# 3. Set the enemy's starting position to the spawner's position
	enemy_instance.global_position = global_position
	
	# 4. Add the enemy to the main game scene
	get_tree().current_scene.add_child(enemy_instance)
