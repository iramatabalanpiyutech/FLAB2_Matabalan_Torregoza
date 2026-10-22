# FLAB2_Matabalan_Torregoza
Machine Problem 1 — Zodiac Horoscope and Fortune Teller

Application-Specific Open-Ended Questions
1. Explain how your determine_zodiac procedure identifies the correct sign from the birth month and day. Describe at least two conditional comparisons.

My determine_zodiac procedure identifies the zodiac sign by comparing the user's birth month and day with the zodiac date ranges. I used CMP and conditional jumps like JE, JL, and JGE to check the dates. For example, March 21 is classified as Aries, while April 20 is classified as Taurus. These comparisons help the program determine the correct zodiac sign.

2. How does your program handle zodiac date ranges that cross two months, such as Capricorn? Explain the branching logic.

My program handles zodiac signs that cover two months by checking the birth month and day separately. For example, Capricorn starts on December 22 and ends on January 19. I used conditional comparisons to check if the entered date falls within either part of that range. This allows the program to identify Capricorn correctly even though the dates belong to different months.

3. Why did you divide input collection, date validation, zodiac identification, and horoscope display into separate procedures?

I divided these tasks into separate procedures to make my program more organized and easier to understand. Each procedure has its own responsibility, such as get_user_info for collecting input and validate_birthdate for checking dates. This also makes debugging easier because I can identify which part of the program has an error. Using procedures also helps reduce repeated code.

4. Describe how your program rejects invalid dates such as February 30 and an invalid month such as 13.

My program uses the validate_birthdate procedure to check if the entered month and day are valid. I used CMP and conditional jumps to compare the input with the allowed values. For example, February 30 is rejected because February does not have 30 days, while month 13 is invalid because there are only 12 months. When the input is invalid, the program displays an error message and asks the user to try again.

5. How does the program select a horoscope category after the user enters a menu choice? Identify the conditional jump instructions used.

My program uses the display_menu procedure to show the available horoscope categories. After the user enters a choice, I used CMP and JE to check which option was selected. For example, choosing 1 displays the love horoscope, while choosing 2 displays the career horoscope. The show_horoscope procedure then displays the prediction based on the selected category.

6. How did you implement the zodiac ASCII art? Explain how the correct design is selected and displayed.

I implemented the zodiac ASCII art by storing text-based designs in the .data section. The display_zodiac_art procedure selects the design based on the user's zodiac sign. The program uses a printing procedure to display the ASCII characters in the terminal. This makes the program more creative and visually interesting.

7. What happens when a user enters an invalid menu option? Explain how control returns to the menu.

When the user enters an invalid menu option, my program displays an error message. I used CMP and conditional jumps to check if the selected number matches the available options. If the choice is invalid, the program uses a jump instruction to return to the menu loop. This allows the user to enter another choice without restarting the program.

8. If you added a new horoscope category, which procedures and conditional branches would you modify? Explain why.

If I added another horoscope category, I would modify the display_menu and show_horoscope procedures. I would add the new category to the menu and include another CMP and JE comparison to recognize the new choice. I would also add a new horoscope prediction in the .data section. These changes would allow the program to display the additional category without affecting the existing ones.

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