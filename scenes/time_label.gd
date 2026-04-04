extends Label

@onready var camera = get_node("../../Camera2D")

# These are the offsets from the top-left of the screen
# Adjust these numbers to move the timer where you want it!
var offset_x = -70
var offset_y = -100

func _process(_delta: float) -> void:
	if camera:
		# We set the label's position to match the camera's center
		# then we add our offsets to put it in the corner.
		global_position.x = camera.global_position.x + offset_x
		global_position.y = camera.global_position.y + offset_y
