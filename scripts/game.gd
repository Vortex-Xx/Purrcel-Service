extends Node2D

@onready var survival_timer = $SurvivalTimer
@onready var time_label = $CanvasLayer/TimeLabel

func _process(_delta):
	# time_left gives us the remaining seconds (e.g. 59.432)
	# we use ceil() to round up to the nearest whole second
	var time_remaining = ceil(survival_timer.time_left)
	time_label.text = "SURVIVE: " + str(time_remaining) + "s"

func _on_survival_timer_timeout() -> void:
	# This runs when the 60 seconds are up!
	win_game()

func win_game():
	# Stop the game logic
	get_tree().paused = true
	# You can show a "YOU WON" message here
	time_label.text = "YOU WON!"
	# Wait 3 seconds then go back to menu
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
