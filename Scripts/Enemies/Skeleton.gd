extends "res://Scripts/Enemies/Enemy.gd"

@onready var timer: Timer = $Timer

func _on_timer_timeout() -> void:
	if attacking:
		anim.play("Attack 1")


func Idle() -> void:
	print("Going to idle")
	anim.play("Idle")


func _on_player_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("playerHitbox"):
		attacking = true
		canMove = false
		timer.start()
		anim.play("Attack 1")


func Kill() -> void:
	super()
	# levelController.AddXP(xp)
	# canMove = false
	timer.stop()
	# anim.play("Death")


func _on_player_detect_area_exited(area: Area2D) -> void:
	if area.is_in_group("playerHitbox"):
		canMove = true
		anim.play("Move")
