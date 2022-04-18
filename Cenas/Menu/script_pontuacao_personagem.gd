extends Label

func _ready():
	if(ScriptGlobal.personagem == 1):
		text = "Naruto"
	if(ScriptGlobal.personagem == 2):
		text = "Sasuke"


