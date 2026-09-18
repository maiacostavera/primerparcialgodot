extends Node
## Bus de señales: sirve para que cosas lejanas se avisen sin conocerse.

signal coins_changed(total: int)
signal health_changed(current: int, maximum: int)
signal player_died
