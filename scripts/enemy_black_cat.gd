extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

const SPEED = 150.0

# Start moving Left (-1)
var direction: int = -1:
	set(value):
		direction = value
		if sprite:
			# If it was moving right while looking left, we swap this:
			# This now says: Flip ONLY when moving Left (-1)
			sprite.flip_h = (direction == -1)

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	# Initial direction
	direction = -1

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	# Detect wall and reverse direction
	if is_on_wall():
		direction *= -1

	velocity.x = direction * SPEED
	move_and_slide()


func _on_killzone_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die() 
