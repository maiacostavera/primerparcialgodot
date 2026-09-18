extends Area2D
## La puerta del final del pozo. Cuando la toca el jugador se abre y termina el nivel.

const ABIERTA_ARRIBA := preload("res://assets/door/door_open_top.png")
const ABIERTA_ABAJO := preload("res://assets/door/door_open.png")

@onready var sprite_top: Sprite2D = $SpriteTop
@onready var sprite_bottom: Sprite2D = $SpriteBottom
@onready var sound: AudioStreamPlayer = $Sound

var _opened: bool = false


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if _opened or not body.is_in_group("player"):
		return
	_opened = true
	sprite_top.texture = ABIERTA_ARRIBA
	sprite_bottom.texture = ABIERTA_ABAJO
	sound.play()
	Events.level_won.emit()
