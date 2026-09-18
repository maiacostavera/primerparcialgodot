extends CanvasLayer
## Pantalla de ganaste. La abre el nivel cuando el jugador llega a la puerta.

## Cuántas frutas hay repartidas en el nivel.
const TOTAL_FRUTAS: int = 5

@onready var coin_label: Label = $Rows/CoinLabel


func _ready() -> void:
	coin_label.text = "FRUTAS: %d de %d" % [GameState.coins, TOTAL_FRUTAS]
	# frenamos el juego, pero esta pantalla sigue andando (Modo de Proceso = Siempre)
	get_tree().paused = true


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().paused = false
		GameState.reset()
		get_tree().reload_current_scene()
