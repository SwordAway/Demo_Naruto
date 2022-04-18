extends CanvasLayer
# HUD
onready var barra_vida_naruto = get_node("Control/Naruto/Barra_vida")
onready var barra_vida_sasuke = get_node("Control/Sasuke/Barra_vida")

onready var barra_furia_naruto = get_node("Control/Naruto/Barra_furia")
onready var barra_furia_sasuke = get_node("Control/Sasuke/Barra_furia")


func _ready():
	
	if(ScriptGlobal.dispositivo == false):
		$Control/Pause.visible = true
	else:
		$Control/Pause.visible = false
	
	if(ScriptGlobal.personagem != 1):
		$Control/Naruto.visible = false
		$Control/Sasuke.visible = true
	else:
		$Control/Sasuke.visible = false
		$Control/Naruto.visible = true
	pass 
	

func _process(delta):
	
# Passa a variavel global para a barra de progresso
	barra_vida_naruto.value = ScriptGlobal.vida
	barra_vida_sasuke.value = ScriptGlobal.vida
	
	barra_furia_naruto.value = ScriptGlobal.furia
	barra_furia_sasuke.value = ScriptGlobal.furia
	
	
#	Controla a cor da barra de vida de acordo com a vida
	if(ScriptGlobal.vida >=75): # Verde
		barra_vida_naruto.set_tint_progress(Color(0, 0.729412, 0.035294))
		barra_vida_sasuke.set_tint_progress(Color(0, 0.729412, 0.035294))
	if(ScriptGlobal.vida <=74): # Verde amarelado
		barra_vida_naruto.set_tint_progress(Color(0.592157, 0.729412, 0.035294))
		barra_vida_sasuke.set_tint_progress(Color(0.592157, 0.729412, 0.035294))
	if(ScriptGlobal.vida <=50): # Laranja avermelhado
		barra_vida_naruto.set_tint_progress(Color(0.898039, 0.380392, 0.035294))
		barra_vida_sasuke.set_tint_progress(Color(0.898039, 0.380392, 0.035294))
	if(ScriptGlobal.vida <=25):# Vermelho
		barra_vida_naruto.set_tint_progress(Color(0.898039, 0, 0.035294))
		barra_vida_sasuke.set_tint_progress(Color(0.898039, 0, 0.035294))
	
#	Se chegar a furia 100, libera animação de ativar furia
	if(ScriptGlobal.furia != 100):
		$Control/Anima.stop()
		$Control/Furia_completa.visible = false
	else:
		if(ScriptGlobal.personagem != 1):
			$Control/Anima.play("furia_completa_sasuke")
		else:
			$Control/Anima.play("furia_completa_naruto")
		
	pass
