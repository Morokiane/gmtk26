extends Node
var soundPath = "res://SFX/"

@onready var soundPlayers = get_children()

var sounds = {
	"enemydie" : load(soundPath + "EnemyDie.wav"),
	"hurt" : load(soundPath + "Hurt.wav"),
	"jump" : load(soundPath + "Jump.wav"),
	"powerup" : load(soundPath + "Powerup.wav"),
	"land" : load(soundPath + "Land.wav"),
	"death" : load(soundPath + "Death.wav"),
	"hit" : load(soundPath + "Hit.wav"),
	"planthit" : load(soundPath + "PlantHit.wav"),
	"rockbroke" : load(soundPath + "RockBroke.wav"),
	"hardmetal" : load(soundPath + "HardMetal.wav"),
	"playerhit" : load(soundPath + "PlayerHit.wav"),
	"fairy" : load(soundPath + "Fairy.wav"),
	"pit" : load(soundPath + "Pit.wav"),
	"gameboystartup" : load(soundPath + "GameboyStartUp.mp3"),
	"key" : load(soundPath + "Key.wav"),
	"shop" : load(soundPath + "Shop.wav"),
	"purchase" : load(soundPath + "Coins15.mp3"),
	"explosion" : load(soundPath + "Explosion.wav"),
	"switch" : load(soundPath + "Switch.wav"),
	"doorclose" : load (soundPath + "DoorClose.mp3"),
	"swoosh" : load(soundPath + "Swoosh.wav"),
	"tingle" : load(soundPath + "Tingle.wav"),
	"uievent" : load(soundPath + "UIEvent.wav"),
	"bat" : load(soundPath + "Bat.wav"),
	"fireball" : load(soundPath + "Fireball.wav"),
	"drops" : load(soundPath + "Drops.wav"),
	"caveplant" : load(soundPath + "CavePlant.wav"),
	"save" : load(soundPath + "Save.wav"),
	"roar" : load(soundPath + "Roar.wav"),
	"footsteps" : load(soundPath + "Footsteps.wav"),
	"impact" : load(soundPath + "Impact.wav"),
	"monsterhit" : load(soundPath + "MonsterHit.wav"),
	"swarm" : load(soundPath + "Swarm.wav"),
	"swarmdie" : load(soundPath + "SwarmDie.wav"),
	"rooster" : load(soundPath + "Rooster.wav"),
	"wrong" : load(soundPath + "Wrong.wav"),
	"unlock" : load(soundPath + "Unlock.mp3"),
	"latch" : load(soundPath + "Latch.mp3"),
	"stomp" : load(soundPath + "Stomp.wav"),
	"bossHit" : load(soundPath + "BossHit.wav"),
	"bossMove" : load(soundPath + "BossMove.wav"),
	"bossKey" : load(soundPath + "BossKey.wav"),
	"wormRoll" : load(soundPath + "WormRoll.wav"),
	"blip" : load(soundPath + "Blip.wav"),
	"plasma" : load(soundPath + "PlasmaGrenade.wav"),
	"tahionbomb" : load(soundPath + "TahionBomb.wav"),
	"teleport" : load(soundPath + "Teleport.wav"),
	"waterfall" : load(soundPath + "Waterfall.wav"),
	"pixelpunch" : load(soundPath + "PixelPunch.wav"),
	"magicbolt" : load(soundPath + "MagicBolt.wav")
	
	# "shopBG" : load (soundPath + "ShopBG.mp3")
}

func play(soundString):
	for soundPlayer in soundPlayers:
		if not soundPlayer.playing:
			soundPlayer.stream = sounds[soundString]
			soundPlayer.play()
			return

func stop(soundString):
	for soundPlayer in soundPlayers:
		if soundPlayer.playing:
			soundPlayer.stream = sounds[soundString]
			soundPlayer.stop()
