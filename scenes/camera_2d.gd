extends Camera2D

# 1. Drag your PlayerCat node into this variable in the Inspector 
# or use the path below:
@onready var player = get_node("../PlayerCat")

# 2. This stores the height where the camera should stay
var fixed_y: float

func _ready() -> void:
	# Save the starting height of the camera
	fixed_y = global_position.y

func _process(_delta: float) -> void:
	if player:
		# Update ONLY the X position to match the cat
		global_position.x = player.global_position.x
		
		# Keep the Y position exactly where it started
		global_position.y = fixed_y
