extends Node

#@export var maxHealth: int = 100
#@export var maxMana: int = 30
#@export var attackRate: float
#@export var moveSpeed: float
#@export var critChance: float
#@export var critDamage: float
#@export var healthRegen: int
#@export var damage: int
#@export var armureMitigation: int
@export var enemyDamage: int = 5
@export var spawnTime: float
@export var enemyLevel: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
