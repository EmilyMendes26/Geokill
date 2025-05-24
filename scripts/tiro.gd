extends Area2D

const limite_mapa = 32
var velocidade = 16
var tempo_tiro = 0.5
var tempo = 0

func _physics_process(delta):
	tempo += delta
	
	if tempo >= tempo_tiro:
		position.y -= velocidade
		tempo = 0.0
	
	if (position.y <= -limite_mapa):
		queue_free()
