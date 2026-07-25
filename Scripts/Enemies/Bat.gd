extends "res://Scripts/Enemies/Enemy.gd"

@onready var coll: CollisionShape2D = $PlayerDetect/CollisionShape2D

func _on_player_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("playerHitbox"):
		coll.set_deferred("disabled", false)
		# canMove = false
		anim.play("Attack 1")