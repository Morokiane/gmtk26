extends CharacterBody2D

@onready var hitbox: Area2D = $Hitbox
@onready var hurtbox: Area2D = $Hurtbox
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var player: Player = get_tree().get_first_node_in_group("player")

@export var health: int = 1
@export var  moveSpeed: float = 20.0

var direction: Vector2 = Vector2.LEFT
var canMove: bool = true
var knockback: int = 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	print("Player health: ", player.currentHealth)

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
	position.x = position.x + knockback
	health -= 1
	anim.play("Hit")
	print("Health: ", health)
	
	if health <= 0:
		Kill()

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("attack"):
		print("Should damage enemy")
		Damage()
		
func ResetAnimation() -> void:
	anim.play("Move")
	
func Kill() -> void:
	canMove = false
	anim.play("Death")