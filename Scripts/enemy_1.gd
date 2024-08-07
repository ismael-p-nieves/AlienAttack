extends Area2D

signal enemy_dead

@export var speed : float

func _physics_process(delta: float) -> void:
	global_position.x -= speed * delta

func take_damage():
	emit_signal("enemy_dead")
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	body.take_damage()
	take_damage()
