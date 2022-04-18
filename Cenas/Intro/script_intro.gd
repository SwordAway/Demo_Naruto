extends Node

func _ready():
	$Delay_inicial.start()
	ScriptGlobal.intro = true

func _on_Anima_animation_finished(anim_name):
	if(anim_name == "intro"):
		ScriptChangeLoading.ir_para("res://Cenas/Login/cena_login.tscn",self)

func _on_Delay_inicial_timeout():
	$Anima.play("intro")




