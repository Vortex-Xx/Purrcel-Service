extends Control

# Drag your game.tscn file here from the FileSystem into the slot in the Inspector
@export_file("*.tscn") var game_scene_path: String

@onready var story_label = $PanelContainer/RichTextLabel
@onready var start_button = $StartButton

func _ready() -> void:
	# 1. Ensure the game is NOT paused when returning to menu
	Engine.time_scale = 1.0
	get_tree().paused = false
	
	# 2. Typewriter Effect: Start with 0 characters visible
	story_label.visible_ratio = 0.0
	var tween = create_tween()
	# Reveals text over 4 seconds
	tween.tween_property(story_label, "visible_ratio", 1.0, 4.0)

func _on_start_button_pressed() -> void:
	# Change to the game scene
	if game_scene_path != "":
		get_tree().change_scene_to_file(game_scene_path)
	else:
		print("Error: You forgot to drag the game scene into the Inspector!")
