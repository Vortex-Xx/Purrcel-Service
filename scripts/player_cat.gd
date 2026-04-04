extends CharacterBody2D
# 1. Add these variables at the top
var score: float = 0.0
@onready var score_label = get_node("../HUD/ScoreLabel") # Make sure this path matches your scene!
# Preload the UI scene so we can spawn it when the player dies
const GAME_OVER_SCENE = preload("res://scenes/GameOver_Screen.tscn")

const SPEED = 110.0
const JUMP_VELOCITY = -250.0

func _physics_process(delta: float) -> void:
	score += 10 * delta
	if score_label:
			score_label.text = str(floor(score))
	else:
		# If you see this in the output, the code can't find your Label!
		print("ScoreLabel not found!")
	# 1. Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		if score_label:
			score_label.text = str(floor(score))
		
	

	# 2. Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 3. Get input direction (-1, 0, or 1)
	var direction := Input.get_axis("ui_left", "ui_right")
	
	# 4. Apply movement AND Animations
	if direction != 0:
		velocity.x = direction * SPEED
		
		# Play the 'run' animation you created
		$AnimatedSprite2D.play("run")
		
		# Flip the sprite based on direction (True if -1, False if 1)
		$AnimatedSprite2D.flip_h = (direction < 0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		# Play the 'idle' animation when standing still
		$AnimatedSprite2D.play("idle")

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


func _on_timer_timeout() -> void:
	pass # Replace with function body.
