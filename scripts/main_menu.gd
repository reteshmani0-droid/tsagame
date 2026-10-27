extends Control

const GAME_SCENE := "res://scenes/game.tscn"

@onready var _play: Button = %PlayButton
@onready var _quit: Button = %QuitButton

func _ready() -> void:
	_play.pressed.connect(_on_play_pressed)
	_quit.pressed.connect(_on_quit_pressed)
	_play.grab_focus()

	# A web build has no window to close, so quit is pointless there.
	if OS.has_feature("web"):
		_quit.hide()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(GAME_SCENE)

func _on_quit_pressed() -> void:
	get_tree().quit()
