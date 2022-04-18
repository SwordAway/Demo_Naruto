extends Area2D

var mov = Vector2(300, 0)

func _ready():
	$Anima.play("foice")
	$Timer.start()


func _delete():
	$Colli_foice.queue_free()
	$Colli_foice2.queue_free()
	$IMG_foice2.queue_free()
	$IMG_foice.queue_free()
	$Anima.queue_free()
	$Timer.start()
	
func _process(delta):
	translate(mov * delta)

# Atingir areas especificas
func _on_Foice_area_entered(area):
	if(area.name == "Clone" || area.name == "Shuriken" || area.name == "Bola_fogo" || area.name == "Recebe_dano"):
		if(ScriptGlobal.status_som):
			if(area.name == "Shuriken"):
				$Som_foice_shuriken.play()
			if(area.name == "Recebe_dano" || area.name == "Clone"):
				$Som_foice_acerta_corpo.play()
		_delete()


# Atingir mundo
func _on_Foice_body_entered(body):
	get_parent().get_node(".").queue_free()

func _on_Timer_timeout():
	get_parent().get_node(".").queue_free()
