extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var buildingDeployed = false
var cementResourceGenerated = 1
var contaminationPoint = 1 # add into the contamination system later
var spaceTaken = 2 # add space constraint later
var cementBuildingLevel = 0

signal buildingIsDeployed
signal resourceCount 
signal contaminationAdd
signal updateSpaceTaken
signal upgrade_cement_building
signal deduct_resources_for_cement_bldg
signal notify_max_level_achieved
signal updateVillageScreen

var timeCheck = 1
var timeStart
var timeSave = false
var isUpdated = false
var buildingDeploying = false

func _ready():
	#Upon initialization, hide the building because it's already placed there
	self.hide()
	for child in self.get_children():
		for things in child.get_children():
			things.hide()
	# Called when the node is added to the scene for the first time.
	# Initialization here
	#pass

func _process(delta):
	#Generates resource per the stipulated time
	if buildingDeployed == true:
		if timeSave == false:
			timeStart = OS.get_system_time_secs()
			timeSave = true
				#resource_production()
				#timeSave == false
		if ((OS.get_system_time_secs() - timeStart) == timeCheck):
			resource_production();
			timeSave = false
			
	if cementBuildingLevel == 1:
		if isUpdated == false:
			level_one()
			isUpdated = true
	if cementBuildingLevel == 2:
		if isUpdated == false:
			level_two()
			isUpdated = true
				
		
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func level_one():
	buildingDeployed = true
	emit_signal("buildingIsDeployed")
	self.show()
	$BldgImg.visible = true
	$Building_UI.visible = true
	$Building_UI/Building_Name.visible = true
	
func level_two():
	buildingDeployed = true
	emit_signal("buildingIsDeployed")
	self.show()
	$BldgImg.visible = true
	$Building_UI/Building_Name.visible = true
	self.get_node("LevelupScheme").show()
	self.get_node("LevelupScheme/level2_cementimg").show()
	
func _on_Building_ProgBar_building_complete():
	buildingDeployed = true
	cementBuildingLevel = 1
	emit_signal("buildingIsDeployed")
	
func resource_production():
	emit_signal("resourceCount", cementResourceGenerated)



func _on_BuildingMenu_deploy_building_cement():
	#When signal deploy_building is emitted by buildingmenu, i.e. building chosen , building appears on village
	var current_ygg_level = get_node("../../").yggdrasilLevel
	
	if(cementBuildingLevel < current_ygg_level):
		if buildingDeploying == true:
			pass
		else:
			buildingDeploying = true
			emit_signal("deduct_resources_for_cement_bldg")
			emit_signal("updateSpaceTaken",spaceTaken)
			emit_signal("contaminationAdd",contaminationPoint)
			if (cementBuildingLevel == 0):
				self.show()	
				var checklevelupgradegraphics = self.get_child(2)
				for child in self.get_children():
					if child == checklevelupgradegraphics:
						pass
					else:				
						for things in child.get_children():
							things.show()  
			else:
				upgrade()
	else:
		emit_signal("notify_max_level_achieved") 
				
func upgrade():
	emit_signal("upgrade_cement_building")


func _on_Levelupbar_cement_upgrade_cement_bldg_complete():
	cementBuildingLevel +=1
	contaminationPoint = contaminationPoint * cementBuildingLevel
	cementResourceGenerated = cementResourceGenerated * cementBuildingLevel
	emit_signal("updateSpaceTaken",spaceTaken)
	emit_signal("contaminationAdd",contaminationPoint)
	buildingDeploying = false


func _on_VillageScreen_firebase_update_cementBldg(cementBldglvl):
	cementBuildingLevel = cementBldglvl


func _on_VillageScreen_update_village_screen():
	emit_signal("updateVillageScreen",cementBuildingLevel)
