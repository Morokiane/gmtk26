extends Node

signal xpChange
signal upgradePointsChanged

@onready var player: Player = get_tree().get_first_node_in_group("player")

var xp: int = 0
var nextXP: int = 5
var growthRate: float = 1.5
var upgradePoints: int = 0

var abilityLevels: Dictionary = {
	"health": 0,
	"mana": 0,
	"healthRegen": 0,
	"damage": 0,
	"attackRate": 0,
	"critChance": 0,
	"critDamage": 0,
	"blockChance": 0,
	"knockback": 0
}

var maxLevels: Dictionary = {
	"health": -1,
	"mana": -1,
	"healthRegen": 10,
	"damage": 20,
	"attackRate": 20,
	"critChance": 20,
	"critDamage": 20,
	"blockChance": 20,
	"knockback": 20
}

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
	
	if xp >= nextXP:
		PlayerLevelUp()
	
func PlayerLevelUp() -> void:
	player.level += 1
	xp = 0
	nextXP = int(nextXP * growthRate)
	upgradePoints += 1
	xpChange.emit()
	upgradePointsChanged.emit()

func UpgradeAbility(ability: String) -> void:
	abilityLevels[ability] += 1
	upgradePoints -= 1
	upgradePointsChanged.emit()
	
#func IncreaseXPLevel() -> void:
#	player.level += 1
#	xp = 0
#	nextXP = int(nextXP * growthRate)
#	# print("XP: ", xp, " Next XP: ", nextXP, " Player level: ", player.level)
#	xpChange.emit()
	
func IsMaxed(ability: String) -> bool:
	var cap = maxLevels[ability]
	return cap != -1 && abilityLevels[ability] >= cap