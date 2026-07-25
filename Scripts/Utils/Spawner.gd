extends Node2D

@onready var player: Player = get_tree().get_first_node_in_group("player")

@export var enemyUn: PackedScene
@export var enemyDeux: PackedScene
@export var enemyTrois: PackedScene
@export var enemyQuatre: PackedScene
@export var enemyCinq: PackedScene
@export var enemySix: PackedScene

@export var spawnTime: float = 10

@onready var levelController: Node = get_parent()
@onready var timer: Timer = $Timer

var spawnEnemies: bool = true
var enemyUnlocks: Array = []

func _ready() -> void:
	timer.wait_time = spawnTime
	# timer.timeout.connect(_on_timer_timeout)

	enemyUnlocks = [
		{"level": 0, "scene": enemyUn, "weight": 30},
		{"level": 1, "scene": enemyDeux, "weight": 30},
		{"level": 6, "scene": enemyTrois, "weight": 15},
		{"level": 12, "scene": enemyQuatre, "weight": 10},
		{"level": 20, "scene": enemyCinq, "weight": 5},
		{"level": 25, "scene": enemySix, "weight": 2},
	]


func _on_timer_timeout() -> void:
	if spawnEnemies:
		SpawnEnemy()

	
func SpawnEnemy() -> void:
	var scene: PackedScene = PickEnemy(player.level)
	if scene == null:
		return

	var enemy = scene.instantiate()
	# enemy.position = position
	add_child(enemy)


func PickEnemy(level: int) -> PackedScene:
	var unlocked: Array = []
	var totalWeight: int = 0

	for entry in enemyUnlocks:
		if level >= entry["level"]:
			unlocked.append(entry)
			totalWeight += entry["weight"]

	if unlocked.is_empty():
		return null

	var roll: float = randf() * totalWeight
	var cumulative: float = 0

	for entry in unlocked:
		cumulative += entry["weight"]
		if roll < cumulative:
			return entry["scene"]
	
	return unlocked.back()["scene"]


# func GetEnemySceneForLevel(level: int) -> PackedScene:
# 	var chosen: PackedScene = null
# 	for entry in enemyUnlocks:
# 		if level >= entry["level"]:
# 			chosen = entry["scene"]
# 		else:
# 			break

# 	return chosen