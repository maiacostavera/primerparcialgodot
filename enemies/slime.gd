extends CharacterBody2D
## Camina en línea recta y se da vuelta cuando choca una pared o se le termina el piso.

const SPEED: float = 35.0
const GRAVITY: float = 900.0

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var wall_check: RayCast2D = $WallCheck
@onready var ledge_check: RayCast2D = $LedgeCheck

var _direction: int = 1


func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta

	# WallCheck mira al frente: si toca algo, hay pared.
	# LedgeCheck mira al frente y abajo: si NO toca nada, se terminó el piso.
	if is_on_floor() and (wall_check.is_colliding() or not ledge_check.is_colliding()):
		_turn_around()

	velocity.x = float(_direction) * SPEED
	move_and_slide()

	if sprite.animation != "run":
		sprite.play("run")


func _turn_around() -> void:
	_direction *= -1
	# los bichos de Kenney están dibujados mirando a la izquierda, por eso es > y no <
	sprite.flip_h = _direction > 0
	wall_check.target_position.x = 13.0 * float(_direction)
	ledge_check.target_position.x = 13.0 * float(_direction)
