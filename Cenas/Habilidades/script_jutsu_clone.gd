extends Area2D

var mov = Vector2 (200, 0)

func _morrer():
	mov.x = 0
	$Anima.play("fumaca")
	$Timer.queue_free()
	$Colli_corpo.queue_free()
	$Soco.queue_free()
	$Area_range.queue_free()
	if(ScriptGlobal.status_som):
		$Som_clone_sumindo.play()



func _ataque():
	mov.x = 0
	if(ScriptGlobal.personagem == 1):
		$Anima.play("ataque_clone_naruto")
	if(ScriptGlobal.personagem == 2):
		$Anima.play("ataque_clone_sasuke")
	$Timer.queue_free()



func _ready():
	$Imgs.visible = false
	if(ScriptGlobal.personagem == 1):
		$Anima.play("clone_voando_naruto")
	if(ScriptGlobal.personagem == 2):
		$Anima.play("clone_voando_sasuke")
		

func _process(delta):
	
	translate(mov * delta)


# ____ Se entrar em contato com o mundo e parede____
func _on_Clone_body_entered(body):
	if(body):
		_morrer()


func _on_Anima_animation_finished(anim_name):
	
	if (anim_name == "ataque_clone_naruto" || anim_name == "ataque_clone_sasuke"):
		mov.x = 0
		$Anima.play("fumaca")
		if(ScriptGlobal.status_som):
			$Som_clone_sumindo.play()
		
	if(anim_name == "fumaca"):
		get_parent().get_node(".").queue_free()


#____ se acabar o tempo ____
func _on_Timer_timeout():
	_morrer()

#____ se entrar em contato com objeto ____
func _on_Clone_area_entered(area):
	if(area.name == "Identif_object" || area.name == "Identif_atk_player"):
		pass
	else:
		_morrer()
		
		
#____ se entrar em contato com inimigo ____
func _on_Area_range_body_entered(body):
		_ataque()

