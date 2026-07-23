extends Area2D
class_name HurtboxComponent

@onready var sprite: Sprite2D = $"../Sprite2D"
@export var healthComponent: Node
@export var flashTimer: Timer

var floatingText: PackedScene = preload("res://Scenes/Utils/FloatingText.scn")

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	flashTimer.timeout.connect(_on_Timer_timeout)

func _on_area_entered(other_area: Area2D) -> void:
	if !other_area is HitboxComponent:
		return

	if healthComponent == null:
		return

	var hitboxComponent: HitboxComponent = other_area

	Flash()
	healthComponent.Damage(hitboxComponent.damage)

	var instance: Node2D = floatingText.instantiate()
	get_tree().get_first_node_in_group("foregroundlayer").add_child(instance)

	instance.global_position = global_position + (Vector2.UP * 16)

	var formatString: String = "%0.1f"
	if round(hitboxComponent.damage) == hitboxComponent.damage:
		formatString = "%0.0f"
	instance.Start(str(formatString % hitboxComponent.damage))

func Flash():
	sprite.material.set_shader_parameter("flashModifier", 1)
	flashTimer.start()

func _on_Timer_timeout():
	sprite.material.set_shader_parameter("flashModifier", 0)