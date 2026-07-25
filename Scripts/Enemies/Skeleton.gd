extends "res://Scripts/Enemies/Enemy.gd"

@onready var timer: Timer = $Timer

func _on_timer_timeout() -> void:
	if attacking:
		anim.play("Attack 1")


func Idle() -> void:
	anim.play("Idle")


func _on_player_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("playerHitbox"):
		attacking = true
		timer.start()
		canMove = false
		anim.play("Attack 1")


func Kill() -> void:
	super()
	# levelController.AddXP(xp)
	# canMove = false
	timer.stop()
	# anim.play("Death")