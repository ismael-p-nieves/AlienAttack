extends Node2D

signal boss_appear(player)

var lives = 3
var score = 0

@onready var player = $player
@onready var hud = $UI/HUD
@onready var enemy_hit_sound = $enemyHitSound
@onready var explode_sound : AudioStreamPlayer2D = $explodeSound

var game_over_screen = preload("res://Scenes/game_over_screen.tscn")
var boss_scene = preload("res://Scenes/boss.tscn")

func _ready() -> void:
	hud.set_score_label(score)
	hud.set_lives(lives)

func _on_death_zone_area_entered(area: Area2D) -> void:
	area.queue_free()

func _on_player_took_damage() -> void:
	lives -= 1
	explode_sound.play()
	if lives == 0:
		player.die()
		
		await get_tree().create_timer(0.5).timeout
		
		game_over()
	else:
		hud.set_lives(lives)

func _on_enemy_spawner_enemy_spawned(enemy_instance: Variant) -> void:
	enemy_instance.connect("enemy_dead", _on_enemy_dead)
	add_child(enemy_instance)
	
func _on_enemy_dead() -> void:
	score += 100
	hud.set_score_label(score)
	enemy_hit_sound.play()
	
	if score == 1000:
		spawn_boss()
		
func _on_boss_hit() -> void:
	score += 100
	hud.set_score_label(score)
	enemy_hit_sound.play()

func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance: Variant) -> void:
	add_child(path_enemy_instance)
	path_enemy_instance.enemy.connect("enemy_dead", _on_enemy_dead)

func spawn_boss():
	var boss_instance = boss_scene.instantiate()
	boss_instance.global_position = Vector2(1000, 360)
	boss_instance.player = player
	boss_instance.connect("boss_hit", _on_boss_hit)
	boss_instance.connect("boss_dead", game_over)
	add_child(boss_instance)

func game_over():
	var game_over_instance = game_over_screen.instantiate()
	game_over_instance.set_score(score)
	hud.add_child(game_over_instance)
	Engine.time_scale = 0
