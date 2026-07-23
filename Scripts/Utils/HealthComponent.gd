extends Node
class_name HealthComponent

signal died
signal health_changed

@export var maxHealth: float = 10

var currentHealth

func _ready() -> void:
	currentHealth = maxHealth
	
func Damage(damageAmount: float) -> void:
	currentHealth = max(currentHealth - damageAmount, 0)
	health_changed.emit()
	Callable(CheckDeath).call_deferred()
	
func GetHealthPercent() -> float:
	if maxHealth <= 0:
		return 0
		
	return min(currentHealth / maxHealth, 1)
	
func CheckDeath() -> void:
	if currentHealth == 0:
		died.emit()
		owner.queue_free()