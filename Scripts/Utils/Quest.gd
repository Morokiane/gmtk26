extends Label

@export var autoStart: bool = false

func _ready() -> void:
	if autoStart:
		pivot_offset = size / 2
		scale = Vector2.ZERO
		await get_tree().create_timer(1.0).timeout

		var tween_in: Tween = create_tween()
		tween_in.tween_property(self, "scale", Vector2(1.0, 1.0), 1.0).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		await tween_in.finished

		await get_tree().create_timer(1.0).timeout

		var tween_out: Tween = create_tween()
		tween_out.tween_property(self, "scale", Vector2.ZERO, 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
		tween_out.tween_callback(queue_free)