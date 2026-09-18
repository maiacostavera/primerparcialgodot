extends CharacterBody2D
## Se mueve y salta. Si lo toca un enemigo pierde vida y queda invulnerable un ratito.

const SPEED: float = 110.0
const JUMP_VELOCITY: float = -290.0
const GRAVITY: float = 900.0
const MAX_FALL_SPEED: float = 420.0

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var hurt_box: Area2D = $HurtBox
@onready var invuln_timer: Timer = $InvulnTimer
@onready var jump_sound: AudioStreamPlayer = $JumpSound
@onready var dust: CPUParticles2D = $Dust
@onready var hurt_sound: AudioStreamPlayer = $HurtSound


func _ready() -> void:
	hurt_box.body_entered.connect(_on_hurt_box_body_entered)


func _physics_process(delta: float) -> void:
	# gravedad, con un tope de velocidad de caída
	if not is_on_floor():
		velocity.y = minf(velocity.y + GRAVITY * delta, MAX_FALL_SPEED)

	# get_axis devuelve -1, 0 o 1 según las dos acciones
	var direction: float = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED

	if Input.is_action_just_pressed("jump") and is_on_floor():
		_jump()

	move_and_slide()
	_update_animation(direction)


func _jump() -> void:
	velocity.y = JUMP_VELOCITY
	jump_sound.play()
	# las partículas son de un solo tiro, así que alcanza con prenderlas
	dust.emitting = true


func _on_hurt_box_body_entered(_body: Node2D) -> void:
	# si el Timer está corriendo todavía es invulnerable
	if not invuln_timer.is_stopped():
		return
	invuln_timer.start()
	hurt_sound.play()
	GameState.take_damage(1)
	velocity.y = -150.0


func _update_animation(direction: float) -> void:
	var next: String = "idle"
	if not is_on_floor():
		next = "jump" if velocity.y < 0.0 else "fall"
	elif absf(direction) > 0.1:
		next = "run"

	# no la reiniciamos si ya es la que está corriendo
	if sprite.animation != next:
		sprite.play(next)

	if absf(direction) > 0.1:
		sprite.flip_h = direction < 0.0
