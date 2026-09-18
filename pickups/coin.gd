extends Area2D
## Fruta que se junta. El dibujo es una tira de cuadros, así que lo animamos a mano.

const FRAMES_PER_SECOND: float = 15.0

@onready var sprite: Sprite2D = $Sprite
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var sound: AudioStreamPlayer = $Sound
@onready var particles: CPUParticles2D = $Particles

var _time: float = 0.0
var _taken: bool = false


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _process(delta: float) -> void:
	if _taken:
		return
	_time += delta
	if sprite.hframes > 1:
		sprite.frame = int(_time * FRAMES_PER_SECOND) % sprite.hframes


func _on_body_entered(body: Node2D) -> void:
	if _taken or not body.is_in_group("player"):
		return
	_taken = true
	GameState.add_coin(1)
	# la escondemos y la borramos un rato después, si no no se llega a escuchar el sonido
	sprite.visible = false
	collision.set_deferred("disabled", true)
	particles.emitting = true
	sound.play()
	await get_tree().create_timer(0.6).timeout
	queue_free()
