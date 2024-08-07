extends Control


func _on_retry_button_pressed() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()

func set_score(score: int) -> void:
	$Panel/Score.text = "Score: " + str(score)
