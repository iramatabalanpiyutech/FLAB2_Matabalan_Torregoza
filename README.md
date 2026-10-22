# FLAB2_Matabalan_Torregoza
Machine Problem 2 — Dungeon Adventure and Survival Game
1. Explain how initialize_character assigns different health, attack, and potion values for Warrior, Mage, and Archer.

My initialize_character procedure assigns the character's statistics based on the class selected by the player. I used CMP and JE to check whether the player chose Warrior, Mage, or Archer. For example, Warrior receives 100 health, 20 attack points, and 2 potions, while Mage receives 70 health, 30 attack points, and 3 potions. Archer receives 85 health, 25 attack points, and 2 potions.

2. Describe the procedures and conditional jumps used when the player chooses Attack, Defend, Use Potion, or Run.

My battle_enemy procedure handles the player's actions during combat. I used CMP and JE to check whether the player selected Attack, Defend, Use Potion, or Run. Attack reduces the enemy's health, Defend reduces the next enemy attack by 5, and Use Potion calls the use_potion procedure to restore health. Choosing Run ends the current encounter and returns the player to the main menu without advancing.

3. How does your battle_enemy procedure determine whether the player or enemy has been defeated? Explain the comparisons.

My battle_enemy procedure checks the health of both the player and the enemy during combat. I used CMP and conditional jumps like JLE to determine whether either health value has reached zero or below. If the enemy's health reaches zero, the player wins the battle and can continue exploring. If the player's health reaches zero, the program displays the Game Over screen.

4. Explain how you prevent health from exceeding the maximum and prevent potion use when the inventory is empty.

My use_potion procedure checks the player's remaining potions before restoring health. I used CMP and conditional jumps to prevent potion use when the potion count is zero. When a potion is used, the program adds 20 health points but limits the result to the character's maximum health. This prevents invalid health values and keeps the potion count from becoming negative.

5. How is the current dungeon room tracked, and what conditions allow the player to advance to the next room?

My program tracks the current dungeon room using a variable that stores the player's progress. The explore_dungeon procedure checks this value to determine which room should appear. The player advances after defeating the Goblin or completing the Treasure Chamber decision. Running away from an enemy does not advance the player, and defeating the Dragon completes the game.

6. What is the purpose of separating display_status, display_inventory, and battle_enemy into different procedures?

I separated these procedures to make the program easier to understand and manage. The display_status procedure shows the character's health and attack points, while display_inventory shows the gold and remaining potions. The battle_enemy procedure handles combat actions and damage calculations. Keeping these tasks separate makes debugging easier and prevents the code from becoming too complicated.

7. How does your program preserve important register values across procedures and Linux system calls? Give one example.

My program needs to preserve important register values so they are not accidentally changed when calling another procedure. Instructions such as PUSH and POP can save and restore register values when necessary. For example, a procedure can save ECX before using it to pass a string address to a printing routine, then restore it afterward. This helps prevent incorrect calculations and unexpected changes during program execution.

8. If you introduced a fourth room with a stronger enemy, what program data, procedures, and conditions would need to change?

If I added a fourth room, I would update the explore_dungeon procedure to include the new location. I would also add the stronger enemy's health, attack damage, and ASCII art in the .data section. The battle_enemy procedure would need to handle the new enemy's statistics and combat conditions. I would also update the room progression and victory conditions so the player must complete the fourth room before winning.