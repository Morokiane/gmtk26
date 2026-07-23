extends Node2D

@export var enemyUn: PackedScene
@export var enemyDeux: PackedScene
@export var enemyTrois: PackedScene
@export var enemyQuatre: PackedScene
@export var enemyCinq: PackedScene
@export var enemySix: PackedScene

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

#		if GameController.enemyLevel >= 10:
#			instance = redBee.instantiate()
			
#		instance.position = spawn_position
		add_child(instance)
