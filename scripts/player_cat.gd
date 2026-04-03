extends CharacterBody2D

# Preload the UI scene you just created
const GAME_OVER_SCENE = preload("res://scenes/GameOver_screen.tscn")

const SPEED = 120.0
const JUMP_VELOCITY = -250.0

func _physics_process(delta: float) -> void:
	# ... your existing movement code ...
	move_and_slide()
	
func die():
	# Call a function to show the UI
	call_deferred("_show_game_over")

func _show_game_over():
	# 1. Create the UI instance
	var game_over = GAME_OVER_SCENE.instantiate()
	# 2. Add it to the main tree (the current scene)
	get_tree().root.add_child(game_over)
	
	# 3. Optional: Pause the game movement so the cat stops moving
	# You'll need to set the UI node's Process Mode to "Always" for the button to work
	get_tree().paused = true
