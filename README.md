# Pew Pew Pew
## Core Requirements:
### Player:
- [x] can move smoothly in 8 directions using WASD or Arrow Keys
- [x] body along with the gun always points towards the mouse cursor postion
- [x] is able to shoot projectiles (balls/bullets) with the left mouse click and bullets travel in the same direction player is aiming.

### Enemies:
- [x] Enemies spawn in waves from any 4 corners of the map, a new wave begins immediately after the current one is completely destroyed.
- [x] Each new wave is more agressive than the previous one (alongside player too gets stronger to keep the game fair)
- [x] Enemies do get blocked by solid objects, and other enemies.
- [x] Enemies are constantly moving (and looking) towards the player's current position.

### Combat & Interaction:
- [x] Enemy dies with just one bullet
- [x] Player takes damager of 10 (out of 100) on each bullet.
- [x] The game ends when the player runs out of health.
- [x] Level contains solid obstacles that block both player, enemy movement and the projectiles.

### Game Loop:
- [x] The game has both Start and End Screens, with a button to start a new game


## Implementation:
### Player aiming and shooting:
This was relatively straightforward to achieve thanks to godot 4 and it's built-in functions. 
Making the player look/aim at the cursor was achieved by passing `get_global_mouse_position` to Node2D's `look_at(point: Vector2)` that set the player's X+ direction towards the mouse position.
and shooting was simply listening for the left mouse button to be clicked and spawn the projectile at the nozzle of the gun (marker2D to get the position of the nozzle) and apply impulse to it, hence making it shoot in player's forward (x+) direction.

### Enemy spawning and wave logic:
`game.gd` script handles this by spawning an initial wave on `_ready` that stores all the enemies in the `enemies` node and on process we check the number of children in `enemies` node, if they are 0, then we spawn a new wave. after spawning each wave the script increase following properties for the next wave to be more brutal: number of enemies, speed of enemies, how long should an enemy wait before shooting next bullet, and the impulse of the bullet shot by enemy and player (to keep the player always slightly stronger than an enemy)

### Damage dealth between entities:
Since both the player and enemy inherit character.gd script, they have `hit()` function, upon being hit a bullet check if the colliding object has a `hit()` function and call it if it does.
The `hit()` for player subtracts 10 points, and just destroys the scene instance if it's enemy.
