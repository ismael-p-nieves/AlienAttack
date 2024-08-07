extends Area2D

@export var speed : float
@onready var visible_notifier : VisibleOnScreenNotifier2D = $VisibleNotifier

func _ready() -> void:
	visible_notifier.connect("screen_exited", _on_screen_exited)

# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	global_position.x += speed * delta

func _on_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	area.take_damage()
	queue_free()
