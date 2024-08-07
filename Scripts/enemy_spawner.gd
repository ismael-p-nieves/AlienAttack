extends Node2D

signal enemy_spawned(enemy_instance)
signal path_enemy_spawned(path_enemy_instance)

var enemy_scene = preload("res://Scenes/enemy_1.tscn")
var path_enemy_scene = preload("res://Scenes/path_enemy.tscn")
@onready var spawn_positions = $SpawnerPositions
@onready var spawn_positions_array = spawn_positions.get_children()

func _on_timer_timeout() -> void:
	spawn_enemy()
	
func _on_path_enemy_timer_timeout() -> void:
	spawn_path_enemy()

func spawn_enemy():
	var random_spawn = spawn_positions_array.pick_random()
	
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = random_spawn.global_position
	emit_signal("enemy_spawned", enemy_instance)
	#add_child(enemy_instance)

func spawn_path_enemy() -> void:
	var path_enemy_instance = path_enemy_scene.instantiate()
	emit_signal("path_enemy_spawned", path_enemy_instance)
