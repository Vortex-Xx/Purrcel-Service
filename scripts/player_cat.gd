extends CharacterBody2D

# Preload the UI scene so we can spawn it when the player dies
const GAME_OVER_SCENE = preload("res://scenes/GameOver_screen.tscn")

const SPEED = 120.0
const JUMP_VELOCITY = -250.0

func _physics_process(_delta: float) -> void:
	# 1. Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * _delta

	# 2. Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 3. Get input direction (-1, 0, or 1)
	var direction := Input.get_axis("ui_left", "ui_right")
	
	# 4. Apply movement
	if direction:
		velocity.x = direction * SPEED
		# Optional: Flip the sprite based on movement
		# $AnimatedSprite2D.flip_h = (direction == -1)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# This function is called by the Enemy's Area2D or other hazards
func die():
	# We use call_deferred to safely handle the UI/Pause 
	# after the physics engine finished its current calculation
	call_deferred("_show_game_over")

func _show_game_over():
	# 1. Check if a Game Over screen already exists to avoid stacking
	if get_parent().has_node("GameOverScreen"):
		return

	# 2. Create the UI instance
	var game_over = GAME_OVER_SCENE.instantiate()
	game_over.name = "GameOverScreen"
	
	# 3. Add it to the level (parent of the player) 
	# This ensures it gets deleted when the scene reloads
	get_parent().add_child(game_over)
	
	# 4. Pause the game so the cat and enemies stop moving
	get_tree().paused = true
