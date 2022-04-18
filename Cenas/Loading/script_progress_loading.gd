extends ProgressBar

var bg_loading = 0
onready var img1 = $Loading_1
onready var img2 = $Loading_2
onready var img3 = $Loading_3
onready var img4 = $Loading_4




func _bg_aleatorio():
	randomize()
	bg_loading = randi()%4 +1

func _ready():
	_bg_aleatorio()
	print("Bg_loagin: ", bg_loading)
	print("loading: ", ScriptGlobal.loading)
	pass 


func _process(delta):
	if(bg_loading == 1):
		img1.visible = true
		img2.visible = false
		img3.visible = false
		img4.visible = false
		
	if(bg_loading == 2):
		img1.visible = false
		img2.visible = true
		img3.visible = false
		img4.visible = false
	if(bg_loading == 3):
		img1.visible = false
		img2.visible = false
		img3.visible = true
		img4.visible = false
	if(bg_loading == 4):
		img1.visible = false
		img2.visible = false
		img3.visible = false
		img4.visible = true
		
	if(ScriptGlobal.loading != 0):
		$".".visible = true
	else:
		$".".visible = false
	pass
