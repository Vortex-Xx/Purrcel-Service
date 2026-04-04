extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

const SPEED = 110.0

# This is the variable the spawner will change
@export var direction: int = 1:
	set(value):
		direction = value
		if sprite:
			# If direction is -1, flip is true. If 1, flip is false.
			sprite.flip_h = (direction == -1)

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	# Keep this empty! If you put 'direction = -1' here, it breaks everything.
	pass

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
