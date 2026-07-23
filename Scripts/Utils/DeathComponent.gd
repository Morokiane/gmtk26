extends Node

@export var sprite: Sprite2D
@export var healthComponent: Node

func _ready() -> void:
	$GPUParticles2D.texture = sprite.texture
	healthComponent.died.connect(_on_died)
	
func _on_died() -> void:
	if owner == null || owner is Node2D:
		return
	
	var spawnPosition: Vector2 = owner.global_position
	
	var entities: Node = get_tree().get_first_node_in_group("entitieslayer")
	get_parent().remove_child(self)
	entities.add_child(self)
#	global_position = spawnPosition
	$AnimationPlayer.play("default")