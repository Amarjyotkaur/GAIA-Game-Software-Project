extends "res://Scripts/Social/ListItem.gd"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _on_Button_pressed():
	main.chat.get_node("Panel/Name").text = $Label.text
	if (!main.chat.chats.has(int(id))):
		main.chat.chats[int(id)] = ""
	main.chat.recipient_id = int(id)
	#main.chat.get_node("Messages").text = main.chat.chats[id]
	main.chat.generateWishList(main.network.player_info[id]["name"])
	main.chat.show()
	#main.Panel2.show()
	
	
