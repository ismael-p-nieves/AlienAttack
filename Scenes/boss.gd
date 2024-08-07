extends Area2D

signal boss_dead
signal boss_hit

var player

@export var health_points : int
@onready var laser_container : Node = $LaserContainer
@onready var laser_timer : Timer = $LaserTimer

var laser_scene = preload("res://Scenes/laser.tscn")

func shoot():
	var laser_instance = laser_scene.instantiate()
	laser_instance.global_position = global_position
	laser_instance.global_position.x -= 80
	laser_instance.player = player
	laser_container.add_child(laser_instance)

func take_damage():
	health_points -= 1
	emit_signal("boss_hit")
	
	if health_points <= 0:
		emit_signal("boss_dead")
		queue_free()

func _on_laser_timer_timeout() -> void:
	shoot()
