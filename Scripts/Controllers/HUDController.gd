extends Node
class_name HUDController

@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var spawner: Node2D = get_tree().get_first_node_in_group("spawner")
@onready var levelController: Node = get_parent()

# Stats
@onready var description: Label = $DescriptionLabel
@onready var levelNum: Label = $VBoxContainer/Level/Num
@onready var damageNum: Label = $VBoxContainer/Damage/Num
@onready var regenNum: Label = $VBoxContainer/HealthRegen/Num
@onready var critCNum: Label = $VBoxContainer/CritC/Num
@onready var critDNum: Label = $VBoxContainer/CritD/Num

# Button levels
@onready var increaseHealthLevel: Label = $GridContainer/IncreaseHealth/Label
@onready var increaseManaLevel: Label = $GridContainer/IncreaseMana/Label
@onready var healthRegenLevel: Label = $GridContainer/HealthRegen/Label
@onready var increaseDamageLevel: Label = $GridContainer/IncreaseDamage/Label
@onready var attackRateLevel: Label = $GridContainer/AttackRate/Label
@onready var critChanceLevel: Label = $GridContainer/CritChance/Label
@onready var critDamageLevel: Label = $GridContainer/CritDamage/Label
@onready var blockChanceLevel: Label = $GridContainer/BlockChance/Label
@onready var knockbackLevel: Label = $GridContainer/Knockback/Label

#Buttons
@onready var increaseHealth: TextureButton = $GridContainer/IncreaseHealth
@onready var increaseMana: TextureButton = $GridContainer/IncreaseMana
@onready var healthRegen: TextureButton = $GridContainer/HealthRegen
@onready var increaseDamage: TextureButton = $GridContainer/IncreaseDamage
@onready var attackRate: TextureButton = $GridContainer/AttackRate
@onready var critChance: TextureButton = $GridContainer/CritChance
@onready var critDamage: TextureButton = $GridContainer/CritDamage
@onready var blockChance: TextureButton = $GridContainer/BlockChance
@onready var knockback: TextureButton = $GridContainer/Knockback
@onready var xpBar: TextureProgressBar = $XPBar
@onready var hpBar: TextureProgressBar = $HPBar

@onready var hordesLeft: Label = $HordesLeft/Num

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
	hordesLeft.text = str(levelController.hordesLeft)
	levelNum.text = str(player.level)
	regenNum.text = str(player.healthRegen)
	damageNum.text = str(player.damage)
	critCNum.text = str(player.critChance)
	critDNum.text = str(player.critDamage)

	for button in upgradeButtons.values():
		button.disabled = true

	spawner.hordeCleared.connect(_on_horde_cleared)
	levelController.xpChange.connect(EnableUpgrade)
	levelController.xpChange.connect(OnXPChanged)
	levelController.upgradePointsChanged.connect(EnableUpgrade)
	player.healthChanged.connect(OnHealthChanged)
	OnHealthChanged()
	EnableUpgrade()
	OnXPChanged()
	UpdateHordesLeft(spawner.hordeCount)
	
	description.text = ""


func _on_horde_cleared(hordeNumber: int) -> void:
	UpdateHordesLeft(spawner.hordeCount - hordeNumber)


func UpdateHordesLeft(amount: int) -> void:
	hordesLeft.text = str(amount)


func OnHealthChanged() -> void:
	hpBar.max_value = player.maxHealth
	hpBar.value = player.currentHealth


func OnXPChanged() -> void:
	levelNum.text = str(player.level)
	critCNum.text = str(player.critChance,"%")
	critDNum.text = str(player.critDamage,"%")
	xpBar.max_value = levelController.nextXP
	xpBar.value = levelController.xp

	
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
	levelController.UpgradeAbility("health")
	increaseHealthLevel.text = str(levelController.abilityLevels["health"])

	
func _on_increase_mana_pressed() -> void:
	player.maxMana += 1
	levelController.UpgradeAbility("mana")
	increaseManaLevel.text = str(levelController.abilityLevels["mana"])

	
func _on_health_regen_pressed() -> void:
	player.regenTimer.wait_time -= 1.0
	player.regenTimer.start()
	regenNum.text = str(player.healthRegen)
	levelController.UpgradeAbility("healthRegen")
	healthRegenLevel.text = str(levelController.abilityLevels["healthRegen"])

	
func _on_increase_damage_pressed() -> void:
	player.damage += 0.1
	damageNum.text = str(player.damage)
	levelController.UpgradeAbility("damage")
	increaseDamageLevel.text = str(levelController.abilityLevels["damage"])

	
func _on_attack_rate_pressed() -> void:
	player.attackTimer.wait_time -= 0.1
	levelController.UpgradeAbility("attackRate")
	attackRateLevel.text = str(levelController.abilityLevels["attackRate"])

	
func _on_crit_chance_pressed() -> void:
	player.critChance += 5.0
	levelController.UpgradeAbility("critChance")
	critChanceLevel.text = str(levelController.abilityLevels["critChance"])

	
func _on_crit_damage_pressed() -> void:
	player.critDamage += 10.0
	levelController.UpgradeAbility("critDamage")
	critDamageLevel.text = str(levelController.abilityLevels["critDamage"])

	
func _on_block_chance_pressed() -> void:
	player.blockChance += 0.1
	levelController.UpgradeAbility("blockChance")
	blockChanceLevel.text = str(levelController.abilityLevels["blockChance"])


func _on_knockback_pressed() -> void:
	player.knockbackAmount += 1
	levelController.UpgradeAbility("knockback")
	knockbackLevel.text = str(levelController.abilityLevels["knockback"])


func EnableUpgrade() -> void:
	var hasPoints: bool = levelController.upgradePoints > 0
#	var hasXP: bool = levelController.xp >= levelController.nextXP
	for ability in upgradeButtons:
		var button: TextureButton = upgradeButtons[ability]
		button.disabled = levelController.IsMaxed(ability) or not hasPoints
