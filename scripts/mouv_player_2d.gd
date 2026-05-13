extends CharacterBody2D

# Constante de vitesse
const SPEED = 200.0

func _physics_process(_delta: float) -> void:
	# 1. Récupérer la direction via les touches fléchées (ou ZQSD par défaut)
	# Get_vector renvoie un Vector2 normalisé (longueur 1)
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# 2. Calculer la vitesse (Vitesse = Direction * Scalaire)
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
	else:
		# Ralentissement immédiat si aucune touche n'est pressée
		velocity = Vector2.ZERO

	# 3. Appliquer le mouvement et gérer les collisions
	move_and_slide()
