extends Label

func _ready():
	if(ScriptGlobal.dificuldade == 1):
		text = "Facil"
	if(ScriptGlobal.dificuldade == 2):
		text = "Media"
	if(ScriptGlobal.dificuldade == 3):
		text = "Dificil"



