extends TextureProgress


# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_VillagerMenu_update_villager_menu(villagerStatus):
	self.value = 50 +  (villagerStatus[1] * 10)
	self.update()

