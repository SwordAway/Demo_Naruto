extends Label

func _ready():
	if(ScriptGlobal.venceu):
		text = "Sim"
	else:
		text = "Nao"
	
