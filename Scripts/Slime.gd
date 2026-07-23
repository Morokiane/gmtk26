extends CharacterBody2D

@onready var hitbox: Area2D = $Hitbox
@onready var hurtbox: Area2D = $Hurtbox
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var hud: HUDController = get_tree().get_first_node_in_group("hud")
@onready var levelController: Node = get_tree().get_first_node_in_group("level")

@export var baseHealth: float = 2.0
@export var baseDamage: float = 1.0
@export var baseMove: float = 20.0
@export var growthRate: float = 1.05

var health: float
var damage: float
var enemyLevel: int = 0
var  moveSpeed: float
var xp: int = 1

var direction: Vector2 = Vector2.LEFT
var canMove: bool = true
var knockback: int = 10
const floatingText: PackedScene = preload("res://Scenes/Utils/FloatingText.scn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	SetLevel(player.level)
	print("Enemy Level: ", enemyLevel)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity = direction * moveSpeed
	set_up_direction(Vector2.UP)

	if canMove:
		move_and_slide()
		
func SetLevel(level: int) -> void:
	enemyLevel = level
	health = baseHealth * pow(growthRate, enemyLevel)
	damage = baseDamage * pow(growthRate, enemyLevel)
	moveSpeed = baseMove * pow(growthRate, enemyLevel)

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("playerHitbox"):
		canMove = false
		anim.play("Explode")
		
func _on_hurtbox_area_entered(area: Area2D) -> void:
#	print("Hurtbox detected: ", area.name, " groups: ", area.get_groups())
	if area.is_in_group("attack"):
#		print("Should damage enemy")
		Damage()
		
func Damage() -> void:
	var result: Dictionary = player.CalculateDamage()
	var dmg: float = result["amount"]
	var isCrit: bool = result["isCrit"]
	
	var instance: Node2D = floatingText.instantiate()
	get_tree().get_first_node_in_group("foreground").add_child(instance)
	instance.global_position = global_position + (Vector2.UP * 16)
	
	var formatString: String = "%0.1f"
	if round(dmg) == dmg:
		formatString = "%0.0f"
	instance.Start(str(formatString % dmg), isCrit)
	
	position.x = position.x + player.knockbackAmount
	health -= dmg
	anim.play("Hit")
	
	if health <= 0:
		Kill()

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("attack"):
		Damage()
		
func ResetAnimation() -> void:
	anim.play("Move")
	
func Kill() -> void:
	levelController.AddXP(xp)
	canMove = false
	anim.play("Death")