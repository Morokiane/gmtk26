extends CharacterBody2D

@onready var playerDetect: RayCast2D = $PlayerDetect
@onready var hitbox: Area2D = $Hitbox
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

@export var moveSpeed: float = 20.0

#const JUMP_VELOCITY = -400.0

var direction: Vector2 = Vector2.LEFT
var canMove: bool = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity = direction * moveSpeed
	set_up_direction(Vector2.UP)
#	# Handle jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

	if canMove:
		move_and_slide()
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		timer.start()
		canMove = false
		anim.play("Idle")
		print("found the player")
		
func _on_timer_timeout() -> void:
	anim.play("Attack 1")
	print(timer.wait_time)
	
func Idle() -> void:
	anim.play("Idle")