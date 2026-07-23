extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var velocityComponent: Node = $VelocityComponent

@export var alwaysMove: bool = true

var isMoving: bool = false

func _physics_process(delta: float) -> void:
	if isMoving || alwaysMove:
		velocityComponent.AccelerateToPlayer()
	else:
		velocityComponent.Deaccelerate()
		
	velocityComponent.Move(self)
	
func FindPlayer() -> Vector2:
	var playerNode: Node2D = get_tree().get_first_node_in_group("player")
	
	if playerNode != null:
		return(playerNode.global_position - global_position).normalized()
	return Vector2.ZERO
	
func SetMoving(moving: bool) -> void:
	isMoving = moving