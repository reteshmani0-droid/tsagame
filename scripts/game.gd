extends Node2D

const MENU_SCENE := "res://scenes/main_menu.tscn"

const SPEED := 420.0
const PLAYER_SIZE := Vector2(48.0, 48.0)
const GEM_SIZE := Vector2(32.0, 32.0)
const GEM_MARGIN := 24.0

var score := 0

@onready var _player: ColorRect = $Player
@onready var _gem: ColorRect = $Gem
@onready var _score_label: Label = $HUD/Score

func _ready() -> void:
	_player.size = PLAYER_SIZE
	_gem.size = GEM_SIZE
	_player.position = (get_viewport_rect().size - PLAYER_SIZE) * 0.5
	_place_gem()
	_update_score()

func _process(delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	_player.position += direction * SPEED * delta

	var screen := get_viewport_rect().size
	_player.position = _player.position.clamp(
		Vector2.ZERO, screen - PLAYER_SIZE
	)

	if _player.get_rect().intersects(_gem.get_rect()):
		score += 1
		_update_score()
		_place_gem()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file(MENU_SCENE)

func _place_gem() -> void:
	var screen := get_viewport_rect().size
	_gem.position = Vector2(
		randf_range(GEM_MARGIN, screen.x - GEM_SIZE.x - GEM_MARGIN),
		randf_range(GEM_MARGIN, screen.y - GEM_SIZE.y - GEM_MARGIN)
	)

func _update_score() -> void:
	_score_label.text = "Gems: %d" % score
