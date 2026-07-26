extends Node2D

@onready var player: Player = get_tree().get_first_node_in_group("player")

@export var enemyUn: PackedScene
@export var enemyDeux: PackedScene
@export var enemyTrois: PackedScene
@export var enemyQuatre: PackedScene
@export var enemyCinq: PackedScene
@export var enemySix: PackedScene

@export var spawnTime: float = 10

@export var enemiesPerHorde: int = 10
@export var hordeCount: int = 5
@export var canSpawn: bool = true

@onready var levelController: Node = get_parent()
@onready var timer: Timer = $Timer

var spawnEnemies: bool = true
var enemyUnlocks: Array = []

var currentHorde: int = 0
var enemiesSpawnedThisHorde: int = 0
var enemiesAlive: int = 0

signal hordeCleared(hordeNumber: int)
signal all_hordes_cleared

func _ready() -> void:
	timer.wait_time = spawnTime
	# timer.timeout.connect(_on_timer_timeout)

	enemyUnlocks = [
		{"level": 0, "scene": enemyUn, "weight": 30},
		{"level": 1, "scene": enemyDeux, "weight": 30},
		{"level": 3, "scene": enemyTrois, "weight": 15},
		{"level": 5, "scene": enemyQuatre, "weight": 10},
		{"level": 7, "scene": enemyCinq, "weight": 10},
		{"level": 9, "scene": enemySix, "weight": 2},
	]

	currentHorde = 1

	if canSpawn:
		timer.start()


func _on_timer_timeout() -> void:
	if spawnEnemies:
		SpawnEnemy()


func SpawnEnemy() -> void:
	var scene: PackedScene = PickEnemy(player.level)
	if scene == null:
		return

	var enemy = scene.instantiate()
	add_child(enemy)

	enemiesSpawnedThisHorde += 1
	enemiesAlive += 1
	enemy.tree_exiting.connect(_on_enemy_tree_exiting)

	if enemiesSpawnedThisHorde >= enemiesPerHorde:
		spawnEnemies = false


func _on_enemy_tree_exiting() -> void:
	enemiesAlive -= 1

	if enemiesAlive <= 0 and enemiesSpawnedThisHorde >= enemiesPerHorde:
		HordeCleared()


func HordeCleared() -> void:
	hordeCleared.emit(currentHorde)

	if currentHorde >= hordeCount:
		all_hordes_cleared.emit()
		return

	currentHorde += 1
	enemiesSpawnedThisHorde = 0
	spawnEnemies = true

	if currentHorde > 5:
		timer.wait_time = max(spawnTime - (currentHorde * 0.1), 0.5)


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