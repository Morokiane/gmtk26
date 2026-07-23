extends "res://Scripts/Player.gd"

func _on_enemy_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		anim.play("Attack 1")
#		hitboxCol.set_deferred("disabled", false)
#		hitboxCol.disabled = false

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemyattack"):
		Damage()
