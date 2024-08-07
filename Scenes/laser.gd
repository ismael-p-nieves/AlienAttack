extends Area2D

@export var speed : float
@onready var visible_notifier : VisibleOnScreenNotifier2D = $VisibleNotifier

var player
var direction : Vector2

func _ready() -> void:
	visible_notifier.connect("screen_exited", _on_screen_exited)
	look_at(player.global_position)
	direction = (player.global_position - global_position).normalized()

# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	global_position.x += speed * direction.x * delta
	global_position.y += speed * direction.y * delta

func _on_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	body.take_damage()
	queue_free()
