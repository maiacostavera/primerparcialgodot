extends CharacterBody2D
## Mosca: cruza el pozo de un lado al otro haciendo ondas. No le afecta la gravedad.

const SPEED: float = 45.0
## Qué tan marcada es la onda que hace al volar.
const BOB: float = 0.4

@onready var sprite: AnimatedSprite2D = $Sprite

var _direction: int = 1
var _time: float = 0.0


func _physics_process(delta: float) -> void:
	_time += delta
	# avanza en horizontal y sube y baja con un seno, así el vuelo no es una línea recta
	velocity = Vector2(float(_direction) * SPEED, sin(_time * 3.0) * SPEED * BOB)
	move_and_slide()

	# si choca contra una pared se da vuelta
	if is_on_wall():
		_direction *= -1
		# los bichos de Kenney están dibujados mirando a la izquierda
		sprite.flip_h = _direction > 0

	if sprite.animation != "fly":
		sprite.play("fly")
