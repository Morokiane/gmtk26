extends Node2D
class_name Player

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var hitboxCol: CollisionShape2D = $Hitbox/CollisionShape2D
@onready var levelController: Node = get_parent()

@export var maxHealth: int = 100
@export var maxMana: int = 30
@export var attackRate: float
@export var moveSpeed: float
@export var critChance: float
@export var critDamage: float
@export var healthRegen: float
@export var damage: float
@export var armureMitigation: int
@export var blockChance: float
@export var knockbackAmount: int

var currentHealth: int
var canAttack: bool = true
var level: int = 0
var xp: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("player")
	currentHealth = maxHealth
	hitboxCol.disabled = true
	
	print(levelController.enemyDamage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func ResetAttack() -> void:
	anim.play("Idle")
#	hitboxCol.set_deferred("disabled", true)
	
func Damage() -> void:
	currentHealth -= levelController.enemyDamage
	anim.play("Hit")
	print("Player health:", currentHealth)
	
	if currentHealth <= 0:
		Kill()

func Kill() -> void:
	anim.play("Death")