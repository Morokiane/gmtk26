extends "res://Scripts/Enemies/Enemy.gd"

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("playerHitbox"):
		canMove = false
		anim.play("Explode")
