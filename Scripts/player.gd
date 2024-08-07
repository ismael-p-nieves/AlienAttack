extends CharacterBody2D

signal took_damage

@export var speed : float
@onready var rocket_scene = preload("res://Scenes/rocket.tscn")
@onready var rocket_container : Node = $RocketContainer
@onready var laser_sound : AudioStreamPlayer2D = $laserSound

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta: float) -> void:
	velocity = Vector2(0, 0)
	if Input.is_action_pressed("input_right"):
		velocity.x = speed
	if Input.is_action_pressed("input_left"):
		velocity.x = -speed
	if Input.is_action_pressed("input_down"):
		velocity.y = speed
	if Input.is_action_pressed("input_up"):
		velocity.y = -speed
	
	move_and_slide()
	
	var viewport : Vector2 = get_viewport_rect().size
	
	global_position = global_position.clamp(Vector2(0, 0), viewport)
	
func shoot():
	var rocket_instance = rocket_scene.instantiate()
	rocket_container.add_child(rocket_instance)
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x += 80
	laser_sound.play()
	
func take_damage():
	emit_signal("took_damage")

func die():
	queue_free()
