extends CharacterBody2D

@export var posicao: Vector2
const tamanho_mapa = 16
var limite_mapa = 56

func _ready():
	posicao = position
	
func _physics_process(delta: float) -> void:
	if (Input.is_action_just_pressed("direita") && position.x + tamanho_mapa <= limite_mapa):
		position.x += tamanho_mapa
	if (Input.is_action_just_pressed("esquerda") && position.x - tamanho_mapa >= -limite_mapa):
		position.x -= tamanho_mapa
	print(limite_mapa,position.x)
		
