extends Label

var tempo = 0

func _process(delta):
	tempo = ScriptGlobal.timer_ranking
	if(ScriptGlobal.ver_ranking):
		text = var2str(tempo)
