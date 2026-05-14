extends CharacterBody2D

# On définit une vitesse constante (en pixels par seconde)
@export var speed: float = 200.0

func _physics_process(_delta: float) -> void:
	# 1. On récupère le vecteur de direction (x: -1 à 1, y: -1 à 1)
	# Cette fonction gère nativement le fait de ne pas aller plus vite en diagonale
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# 2. On applique la direction à la vitesse (velocity est une propriété interne)
	if direction != Vector2.ZERO:
		velocity = direction * speed
	else:
		# On s'arrête net si aucune touche n'est pressée
		velocity = Vector2.ZERO

	# 3. move_and_slide utilise la propriété 'velocity' pour déplacer le corps
	# Il gère les collisions et le glissement contre les murs sans besoin de gravité
	move_and_slide()
