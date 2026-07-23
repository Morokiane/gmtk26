extends CharacterBody2D

@onready var hitbox: Area2D = $Hitbox
@onready var hurtbox: Area2D = $Hurtbox
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var hud: HUDController = get_tree().get_first_node_in_group("hud")
@onready var levelController: Node = get_tree().get_first_node_in_group("level")

@export var health: int = 1
@export var  moveSpeed: float = 20.0
@export var xp: int = 1

var direction: Vector2 = Vector2.LEFT
var canMove: bool = true
var knockback: int = 10
const floatingText: PackedScene = preload("res://Scenes/Utils/FloatingText.scn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	print("Player health: ", player.currentHealth)
	if hud != null:
		print("found hud")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity = direction * moveSpeed
	set_up_direction(Vector2.UP)

	if canMove:
		move_and_slide()
		
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
	var instance: Node2D = floatingText.instantiate()
	get_tree().get_first_node_in_group("foreground").add_child(instance)
	instance.global_position = global_position + (Vector2.UP * 16)
	
	var formatString: String = "%0.1f"
	if round(player.damage) == player.damage:
		formatString = "%0.0f"
	instance.Start(str(formatString % player.damage))
	
	position.x = position.x + player.knockbackAmount
	health -= player.damage
	anim.play("Hit")
	print("Health: ", health)
	
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