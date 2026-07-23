extends Node

signal xpChange

@onready var player: Player = get_tree().get_first_node_in_group("player")

var xp: int = 0
var nextXP: int = 5
var growthRate: float = 1.5

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
@export var playerLevel: int

func AddXP(amount: int) -> void:
	xp += amount
	xpChange.emit()
	
func IncreaseXPLevel() -> void:
	player.level += 1
	nextXP = int(nextXP * growthRate)
	print("XP: ", xp, " Next XP: ", nextXP, " Player level: ", player.level)
	xpChange.emit()
