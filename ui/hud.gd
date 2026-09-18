extends CanvasLayer
## El HUD se entera de todo por las señales de Events. La única vez que le pregunta
## algo a GameState es al arrancar, para no empezar con los Labels vacíos.

@onready var health_label: Label = $Margin/Rows/HealthLabel
@onready var coin_label: Label = $Margin/Rows/CoinLabel


func _ready() -> void:
	Events.health_changed.connect(_on_health_changed)
	Events.coins_changed.connect(_on_coins_changed)
	_on_health_changed(GameState.health, GameState.max_health)
	_on_coins_changed(GameState.coins)


func _on_health_changed(current: int, maximum: int) -> void:
	health_label.text = "VIDA: %d/%d" % [current, maximum]


func _on_coins_changed(total: int) -> void:
	coin_label.text = "FRUTAS: %d" % total
