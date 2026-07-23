extends Node2D

@onready var player: Player = get_tree().get_first_node_in_group("player")

@export var enemyUn: PackedScene
@export var enemyDeux: PackedScene
@export var enemyTrois: PackedScene
@export var enemyQuatre: PackedScene
@export var enemyCinq: PackedScene
@export var enemySix: PackedScene

@onready var levelController: Node = get_parent()
@onready var timer: Timer = $Timer

var spawnEnemies: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_timer_timeout() -> void:
	SpawnEnemy()
	
func SpawnEnemy() -> void:
#	for i in range(GameController.enemyRate):
	if spawnEnemies:
		var instance: CharacterBody2D = enemyUn.instantiate()

		if levelController.playerLevel >= 10:
			pass
#			instance = redBee.instantiate()
			
#		instance.position = spawn_position
		add_child(instance)
		instance.SetLevel(player.level)
