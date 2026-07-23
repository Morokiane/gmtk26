extends Node2D

func Start(text: String, isCrit: bool = false) -> void:
	$Label.text = text
	
	var randomOffset: Vector2 = Vector2(randf_range(-8.0, 8.0), randf_range(-4.0, 4.0))
	global_position += randomOffset
	
	if isCrit:
		$Label.modulate = Color.ORANGE
		$Label.scale *= 1.3
	
	var tween: Tween = create_tween()
	tween.set_parallel()
	
	tween.tween_property(self, "global_position", global_position + (Vector2.UP * 16), 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.chain()
	
	tween.tween_property(self, "global_position", global_position + (Vector2.UP * 48), 0.4).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)

	tween.tween_property(self, "scale", Vector2.ONE, 0.4).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.chain()

	tween.tween_callback(queue_free)

	var scaleTween: Tween = create_tween()
	scaleTween.tween_property(self, "scale", Vector2.ONE * 2, 0.15).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)

	scaleTween.tween_property(self, "scale", Vector2.ONE, 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)