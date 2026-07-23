extends Node
class_name HUDController

@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var levelController: Node = get_parent()

@onready var description: Label = $DescriptionLabel
@onready var xpNum: Label = $VBoxContainer/XP/Num
@onready var damageNum: Label = $VBoxContainer/Damage/Num
@onready var regenNum: Label = $VBoxContainer/HealthRegen/Num
@onready var goldNum: Label = $VBoxContainer/Gold/Num
@onready var increaseHealth: TextureButton = $GridContainer/IncreaseHealth
@onready var increaseMana: TextureButton = $GridContainer/IncreaseMana
@onready var healthRegen: TextureButton = $GridContainer/HealthRegen
@onready var increaseDamage: TextureButton = $GridContainer/IncreaseDamage
@onready var attackRate: TextureButton = $GridContainer/AttackRate
@onready var critChance: TextureButton = $GridContainer/CritChance
@onready var critDamage: TextureButton = $GridContainer/CritDamage
@onready var blockChance: TextureButton = $GridContainer/BlockChance
@onready var knockback: TextureButton = $GridContainer/Knockback

@onready var upgradeButtons: Dictionary = {
	"health": increaseHealth, 
	"mana": increaseMana,
	"healthRegen": healthRegen,
	"damage": increaseDamage,
	"attackRate": attackRate,
	"critChance": critChance,
	"critDamage": critDamage,
	"blockChance": blockChance,
	"knockback": knockback
}

func _ready() -> void:
	for button in upgradeButtons.values():
		button.disabled = true
	
	levelController.xpChange.connect(EnableUpgrade)
	EnableUpgrade()
	
	description.text = ""

func _process(delta: float) -> void:
	xpNum.text = str(levelController.xp)
	damageNum.text = str(player.damage)
	regenNum.text = str(player.healthRegen)
	
func _on_increase_health_mouse_entered() -> void:
	description.text = "Increase Health"
	
func _on_increase_mana_mouse_entered() -> void: 	
	description.text = "Increase Mana"
	
func _on_health_regen_mouse_entered() -> void:
	description.text = "Increase Health Regen"
	
func _on_increase_damage_mouse_entered() -> void:
	description.text = "Increase Damage"
	
func _on_attack_rate_mouse_entered() -> void:
	description.text = "Attack Rate"
	
func _on_crit_chance_mouse_entered() -> void:
	description.text = "Crit Chance"
	
func _on_crit_damage_mouse_entered() -> void:
	description.text = "Crit Damage"
	
func _on_block_chance_mouse_entered() -> void:
	description.text = "Block Chance"

func _on_knockback_mouse_entered() -> void:
	description.text = "Increase Knockback"
	
func _mouse_exited() -> void:
	description.text = ""

func _on_increase_health_pressed() -> void:
	player.maxHealth += 1
	levelController.IncreaseXPLevel()
	
func _on_increase_mana_pressed() -> void:
	player.maxMana += 1
	levelController.IncreaseXPLevel()
	
func _on_health_regen_pressed() -> void:
	player.healthRegen += 0.1
	levelController.IncreaseXPLevel()
	
func _on_increase_damage_pressed() -> void:
	player.damage += 0.1
	levelController.IncreaseXPLevel()
	
func _on_attack_rate_pressed() -> void:
	player.attackRate += 0.1
	levelController.IncreaseXPLevel()
	
func _on_crit_chance_pressed() -> void:
	player.critChance += 0.1
	levelController.IncreaseXPLevel()
	
func _on_crit_damage_pressed() -> void:
	player.critDamage += 0.1
	levelController.IncreaseXPLevel()
	
func _on_block_chance_pressed() -> void:
	player.blockChance += 0.1
	levelController.IncreaseXPLevel()

func _on_knockback_pressed() -> void:
	player.knockbackAmount += 1
	levelController.IncreaseXPLevel()

func EnableUpgrade() -> void:
	var hasXP: bool = levelController.xp >= levelController.nextXP
	for ability in upgradeButtons:
		var button: TextureButton = upgradeButtons[ability]
		button.disabled = levelController.IsMaxed(ability) or not hasXP
