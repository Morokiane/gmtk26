extends Node

@export var maxSpeed: int = 40
@export var acceleration: float = 5

var velocity: Vector2 = Vector2.ZERO

func AccelerateToPlayer() -> void:
	var instance: Node2D = owner
	
	if owner == null:
		return
		
	var player: Node2D = get_tree().get_first_node_in_group("player")
	if player == null:
		return
	
	var direction: Vector2 = (player.global_position - instance.global_position).normalized()
	AccelerateInDirection(direction)
	
func AccelerateInDirection(direction: Vector2) -> void:
	var desiredVelocity: Vector2 = direction * maxSpeed
	velocity = velocity.lerp(desiredVelocity, 1 - exp(-acceleration * get_process_delta_time()))
	
func Deaccelerate() -> void:
	AccelerateInDirection(Vector2.ZERO)
	
func Move(characterBody: CharacterBody2D) -> void:
	characterBody.velocity = velocity
	characterBody.move_and_slide()
	velocity = characterBody.velocity