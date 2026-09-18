extends Node
## Estado de la partida. Cada cambio avisa por Events.

var max_health: int = 3
var health: int = 3
var coins: int = 0


func add_coin(amount: int = 1) -> void:
	coins += amount
	Events.coins_changed.emit(coins)


func take_damage(amount: int = 1) -> void:
	if health <= 0:
		return
	health = maxi(health - amount, 0)
	Events.health_changed.emit(health, max_health)
	if health <= 0:
		Events.player_died.emit()


func reset() -> void:
	health = max_health
	coins = 0
