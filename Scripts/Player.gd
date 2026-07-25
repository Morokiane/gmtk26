extends Node2D
class_name Player

signal healthChanged

@onready var levelController: Node = get_parent()
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var hitboxCol: CollisionShape2D = $Hitbox/CollisionShape2D
@onready var hurtboxCol: CollisionShape2D = $Hurtbox/CollisionShape2D
@onready var regenTimer: Timer = $RegenTimer
@onready var attackTimer: Timer = $AttackTimer
@onready var enemyDetector: Area2D = $EnemyDetect
@onready var rayCast: RayCast2D = $RayCast2D

@export var maxHealth: int = 100
@export var maxMana: int = 30
@export var attackRate: float
@export var moveSpeed: float
@export var critChance: float
@export var critDamage: float
@export var healthRegen: float = 1
@export var damage: float
@export var armureMitigation: int
@export var blockChance: float
@export var knockbackAmount: int

var currentHealth: float
var canAttack: bool = true
var level: int = 0
var xp: int
var enemyInRange: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("player")
	currentHealth = maxHealth
	hitboxCol.disabled = true
	attackTimer.wait_time = attackRate
	attackTimer.one_shot = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _physics_process(_delta: float) -> void:
	var wasInRange: bool = enemyInRange
	enemyInRange = false

	if rayCast.is_colliding():
		var collider = rayCast.get_collider()
		if collider and collider.is_in_group("enemy"):
			enemyInRange = true

	# Just entered range -> attack right away
	if enemyInRange and not wasInRange and canAttack:
		Attack()


func Attack() -> void:
	canAttack = false
	anim.play("Attack 1")
	attackTimer.start()


func ResetAttack() -> void:
	anim.play("Idle")
#	hitboxCol.set_deferred("disabled", true)

	
func Damage() -> void:
	currentHealth -= levelController.enemyDamage
	anim.play("Hit")
	print("Player health:", currentHealth)
	SoundFx.play("playerhit")
	# Emit health change to the HUDController
	healthChanged.emit()
	
	if currentHealth <= 0:
		Kill()


# Calculate enemy damage
func CalculateDamage() -> Dictionary:
	var isCrit: bool = randf() * 100.0 < critChance
	var finalDamage: float = damage
	
	if isCrit:
		finalDamage *= damage + (critDamage / 100.0)
	
	return {
		"amount": finalDamage,
		"isCrit": isCrit
	}


func Kill() -> void:
	SoundFx.play("death")
	regenTimer.stop()
	attackTimer.stop()
	anim.play("Death")
	levelController.gameOver.visible = true
	# hitboxCol.set_deferred("disabled", true)
	hurtboxCol.set_deferred("disabled", true)


func _on_regen_timer_timeout() -> void:
	currentHealth = min(currentHealth + healthRegen, maxHealth)
	print("Regened health: ", currentHealth)
	healthChanged.emit()


func _on_attack_timer_timeout() -> void:
	canAttack = true
	
	if enemyInRange:
		Attack()


func _on_enemy_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		enemyInRange = true
		anim.play("Attack 1")
		attackTimer.stop()
		attackTimer.start()
		# anim.play("Attack 1")
#		hitboxCol.set_deferred("disabled", false)
#		hitboxCol.disabled = false


func _on_enemy_detect_area_exited(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		var remaining = enemyDetector.get_overlapping_areas().filter(func(b): return b.is_in_group("enemy"))
		if remaining.is_empty():
			enemyInRange = false
			attackTimer.stop()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemyattack"):
		Damage()