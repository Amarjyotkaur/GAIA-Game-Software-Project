extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var networknode
onready var main = get_tree().get_root().get_node("Main")

func _ready():
	$MobBoss1.set_network_master(get_tree().get_network_unique_id())
	set_network_master(get_tree().get_network_unique_id())
	networknode = get_tree().get_root().get_node("Main/Network")
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Button_pressed():
	$UI/ConfirmationDialog.show_modal(true)
	pass # replace with function body


func _on_ConfirmationDialog_confirmed():
#	rpc("goodbye_combat",get_tree().get_network_unique_id())
	hide()
	queue_free()
	main.get_node("Village").play()
	main.get_node("Combat").stop()
	main.get_node("Aggression").stop()
	main.get_node("Sad").stop()
	main.village.show()
#	for i in get_parent().get_children():
#		if "Village" in i.name:
#			i.show()
	
	



func _on_GoBack_pressed():
#	rpc("goodbye_combat",get_tree().get_network_unique_id())
	hide()
	main.get_node("Village").play()
	main.get_node("Combat").stop()
	main.get_node("Aggression").stop()
	main.get_node("Sad").stop()
	main.village.show()
	#for i in get_parent().get_children():
		#if "VillageScene" in i.name:
			#i.show()
	
	
	queue_free()
	
#sync func goodbye_combat(player_id):
##	networknode.players_incombat.erase(player_id)
##	if(get_tree().get_network_unique_id()!=player_id):
##		for i in self.get_children():
##			if str(player_id) in i.name:
##				i.queue_free()
		
	
#sync func try_again():
#	hide()
#	queue_free()
#	var stageOne = load('res://Scenes/Combat/StageOne.tscn').instance()
#	var player = load('res://Scenes/Combat/Player.tscn').instance()
#	player.position=Vector2(50,500)
#	player.set_network_master(get_tree().get_network_unique_id()) #set unique id as master
#	stageOne.add_child(player)
#	get_parent().add_child(stageOne)
	
func _on_TryAgain_pressed():
	main.get_node("Combat").play()
	main.get_node("Aggression").stop()
	main.get_node("Sad").stop()
	hide()
	queue_free()
	var stageOne = load('res://Scenes/Combat/StageOne.tscn').instance()
	var player = load('res://Scenes/Combat/Player.tscn').instance()
	player.position=Vector2(50,500)
	player.set_network_master(get_tree().get_network_unique_id()) #set unique id as master
	stageOne.add_child(player)
	get_parent().add_child(stageOne)
#	rpc("reload_scene")
#	if get_tree().is_network_server():
#		# Send my info to new player
#		for peer_id in networknode.players_incombat:
#			if(peer_id!=1):
#				rpc_id(peer_id, "_on_TryAgain_pressed")
#	# Change scene
#	var world = load("res://Scenes/Combat/MultiStageOne.tscn").instance()
#	get_parent().add_child(world)
#	self.hide()
#
#	var player_scene = load("res://Scenes/Combat/Player.tscn")
#
#	for p_id in networknode.players_incombat:
#		var player = player_scene.instance()
##
#		player.set_name(str("Player")+str(p_id)) # Use unique ID as node name
#		player.position=Vector2(50,500)
#		player.set_network_master(p_id) #set unique id as master
#
##		if p_id == get_tree().get_network_unique_id():
#			# If node for this peer id, set name
##			player.set_player_name(player_name)
##		else:
#			# Otherwise set name from peer
##			player.set_player_name(players[p_id])
#
#		world.add_child(player)
#	queue_free()

#sync func reload_scene():
#	get_tree().reload_current_scene()

func _on_GoBack2_pressed():
#	rpc("goodbye_combat",get_tree().get_network_unique_id())
	hide()
	queue_free()
	main.get_node("Village").play()
	main.get_node("Combat").stop()
	main.get_node("Aggression").stop()
	main.get_node("Victory").stop()
	main.village.show()
#	for i in get_parent().get_children():
#		if "Village" in i.name:
#			i.show()


func _on_TryAgain2_pressed():
	main.get_node("Sad").stop()
	main.get_node("Victory").stop()
	main.get_node("Aggression").stop()
	main.get_node("Combat").play()
	hide()
	queue_free()
	var stageOne = load('res://Scenes/Combat/StageOne.tscn').instance()
	var player = load('res://Scenes/Combat/Player.tscn').instance()
	player.position=Vector2(50,500)
	player.set_network_master(get_tree().get_network_unique_id()) #set unique id as master
	stageOne.add_child(player)
	get_parent().add_child(stageOne)
