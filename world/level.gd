extends Node2D
## Escucha la muerte del jugador y reinicia el nivel.


func _ready() -> void:
	Events.player_died.connect(_on_player_died)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		_restart()


func _on_player_died() -> void:
	# un ratito de pausa dramática y volvemos a empezar
	await get_tree().create_timer(1.0).timeout
	_restart()


func _restart() -> void:
	GameState.reset()
	get_tree().reload_current_scene()
