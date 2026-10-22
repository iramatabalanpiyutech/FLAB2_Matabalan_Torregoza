BITS 32
section .data
welcome db 10,'=======================================',10,'       DUNGEON OF THE LOST KING',10,'=======================================',10,'           |>>>>',10,'           |',10,'       ____|____',10,'      |  _   _  |',10,'      | | | | | |',10,'      |_______  |',10,'       ENTER IF YOU DARE!',10,'=======================================',10,0
askname db 'Enter your hero name: ',0
classes db 10,'Choose your character:',10,'[1] Warrior',10,'[2] Mage',10,'[3] Archer',10,'Enter choice: ',0
warrior db 'Warrior',0
mage db 'Mage',0
archer db 'Archer',0
hi db 10,'Welcome, ',0
space db ' ',0
nl db 10,0
mainmenu db 10,'========= MAIN MENU =========',10,'[1] Explore Dungeon',10,'[2] View Character Status',10,'[3] Use Health Potion',10,'[4] View Inventory',10,'[5] Exit Game',10,'Enter choice: ',0
invalid db 'Invalid selection. Try again.',10,0
statushead db 10,'--- CHARACTER STATUS ---',10,'Hero: ',0
classlabel db 'Class: ',0
healthlabel db 'Health: ',0
maxlabel db 'Maximum Health: ',0
attacklabel db 'Attack: ',0
potionlabel db 'Potions: ',0
goldlabel db 'Gold: ',0
roomlabel db 'Current room: ',0
invhead db 10,'--- INVENTORY ---',10,0
no_potions db 'No potions remaining!',10,0
potionused db 'Potion used. Health restored (up to maximum).',10,0
fullhealth db 'Health is already full; potion consumed.',10,0
goblinart db 10
          db '       ,     ,',10
          db '      /(. .)\',10
          db '     /  o o  \',10
          db '     |   ^   |',10
          db '      \  -  /',10
          db '       -----',10
          db ' A GOBLIN APPEARS!',10,0

chestart db 10
         db '    __________',10
         db '   /_________/|',10
         db '   |  _____  | |',10
         db '   | |  ?  | | |',10
         db '   | |_____| | /',10
         db '   |_________|/',10,0

dragonart db 10
          db '       / \  //\',10
          db '   |\___/|    \',10
          db '   /0 0 \     |',10
          db '  /   ^   \  /',10
          db '  \_______\/',10
          db ' THE DRAGON AWAKENS!',10,0
combatmenu db 10,'[1] Attack  [2] Defend',10,'[3] Use Potion  [4] Run',10,'Enter choice: ',0
enemyhealthlabel db 'Enemy health: ',0
hitmsg db 'You attack the enemy!',10,0
defendmsg db 'You defend against the next attack!',10,0
enemyhit db 'Enemy damage received: ',0
enemydead db 'Enemy defeated!',10,0
ran db 'You escaped. Returning to main menu.',10,0
chestmenu db 10,'[1] Open Chest  [2] Leave Chest',10,'Enter choice: ',0
gotgold db 'You found 50 gold!',10,0
leftgold db 'You left the treasure behind.',10,0
victory db 10,'========== VICTORY! ==========',10,'CONGRATULATIONS, ',0
victory2 db 'You defeated the dragon and escaped!',10,'YOU ARE A HERO!',10,0
gameover db 10,'========== GAME OVER ==========',10,'Your hero has fallen.',10,'The dungeon remains undefeated.',10,'BETTER LUCK NEXT TIME!',10,0
bye db 'Thanks for playing!',10,0
badnumber db 'Please enter a valid number.',10,0
section .bss
namebuf resb 65
inputbuf resb 64
onebyte resb 1
charclass resd 1
hp resd 1
maxhp resd 1
power resd 1
potions resd 1
gold resd 1
room resd 1
enemyhp resd 1
enemydmg resd 1
defending resd 1
choice resd 1
numberbuf resb 16
section .text
global _start
_start:
    call display_welcome
    call get_player_info
    call initialize_character
    mov dword [gold],0
    mov dword [room],1
.main_loop:
    call display_main_menu
    call read_number
    jc .bad_menu
    cmp eax,1
    je .explore
    cmp eax,2
    je .status
    cmp eax,3
    je .potion
    cmp eax,4
    je .inventory
    cmp eax,5
    je exit_program
.bad_menu:
    mov ecx,invalid
    call print_string
    jmp .main_loop
.explore:
    call explore_dungeon
    jmp .main_loop
.status:
    call display_status
    jmp .main_loop
.potion:
    call use_potion
    jmp .main_loop
.inventory:
    call display_inventory
    jmp .main_loop

; print a zero-terminated string whose address is in ECX
print_string:
    pushad
    mov esi,ecx
.find_end:
    cmp byte [esi],0
    je .send
    inc esi
    jmp .find_end
.send:
    mov edx,esi
    sub edx,ecx
    mov eax,4
    mov ebx,1
    int 0x80
    popad
    ret

; read a line into ECX, maximum EDX bytes (including terminator)
read_line:
    pushad
    mov esi,ecx
    mov edi,edx
    dec edi
    xor ebp,ebp
.next:
    mov eax,3
    mov ebx,0
    mov ecx,onebyte
    mov edx,1
    int 0x80
    cmp eax,1
    jne .done
    mov al,[onebyte]
    cmp al,10
    je .done
    cmp al,13
    je .next
    cmp ebp,edi
    jae .next
    mov [esi+ebp],al
    inc ebp
    jmp .next
.done:
    mov byte [esi+ebp],0
    popad
    ret

; returns unsigned integer in EAX, CF=1 for invalid or empty input
read_number:
    push esi
    push ebx
    push edx
    mov ecx,inputbuf
    mov edx,64
    call read_line
    mov esi,inputbuf
    xor eax,eax
    xor ebx,ebx
.loop:
    mov dl,[esi]
    test dl,dl
    jz .finish
    cmp dl,'0'
    jb .error
    cmp dl,'9'
    ja .error
    sub dl,'0'
    movzx edx,dl
    cmp eax,429496729
    ja .error
    jb .multiply
    cmp edx,5
    ja .error
.multiply:
    imul eax,eax,10
    add eax,edx
    inc ebx
    inc esi
    jmp .loop
.finish:
    test ebx,ebx
    jz .error
    clc
    jmp .return
.error:
    stc
.return:
    pop edx
    pop ebx
    pop esi
    ret

; print unsigned EAX as decimal
print_number:
    pushad
    mov edi,numberbuf+15
    mov byte [edi],0
    mov ebx,10
.convert:
    xor edx,edx
    div ebx
    add dl,'0'
    dec edi
    mov [edi],dl
    test eax,eax
    jnz .convert
    mov ecx,edi
    call print_string
    popad
    ret
print_newline:
    mov ecx,nl
    call print_string
    ret

display_welcome:
    mov ecx,welcome
    call print_string
    ret

get_player_info:
    mov ecx,askname
    call print_string
    mov ecx,namebuf
    mov edx,65
    call read_line
.ask_class:
    mov ecx,classes
    call print_string
    call read_number
    jc .invalid
    cmp eax,1
    jl .invalid
    cmp eax,3
    jg .invalid
    mov [charclass],eax
    ret
.invalid:
    mov ecx,invalid
    call print_string
    jmp .ask_class

initialize_character:
    mov eax,[charclass]
    cmp eax,1
    je .warrior
    cmp eax,2
    je .mage
    mov dword [maxhp],85
    mov dword [power],25
    mov dword [potions],2
    jmp .finish
.warrior:
    mov dword [maxhp],100
    mov dword [power],20
    mov dword [potions],2
    jmp .finish
.mage:
    mov dword [maxhp],70
    mov dword [power],30
    mov dword [potions],3
.finish:
    mov eax,[maxhp]
    mov [hp],eax
    mov ecx,hi
    call print_string
    call print_class
    mov ecx,space
    call print_string
    mov ecx,namebuf
    call print_string
    call print_newline
    ret

print_class:
    mov eax,[charclass]
    cmp eax,1
    je .warrior
    cmp eax,2
    je .mage
    mov ecx,archer
    jmp .print
.warrior:
    mov ecx,warrior
    jmp .print
.mage:
    mov ecx,mage
.print:
    call print_string
    ret

display_main_menu:
    mov ecx,mainmenu
    call print_string
    ret

display_status:
    mov ecx,statushead
    call print_string
    mov ecx,namebuf
    call print_string
    call print_newline
    mov ecx,classlabel
    call print_string
    call print_class
    call print_newline
    mov ecx,healthlabel
    call print_string
    mov eax,[hp]
    call print_number
    call print_newline
    mov ecx,maxlabel
    call print_string
    mov eax,[maxhp]
    call print_number
    call print_newline
    mov ecx,attacklabel
    call print_string
    mov eax,[power]
    call print_number
    call print_newline
    mov ecx,roomlabel
    call print_string
    mov eax,[room]
    call print_number
    call print_newline
    ret

display_inventory:
    mov ecx,invhead
    call print_string
    mov ecx,goldlabel
    call print_string
    mov eax,[gold]
    call print_number
    call print_newline
    mov ecx,potionlabel
    call print_string
    mov eax,[potions]
    call print_number
    call print_newline
    ret

use_potion:
    cmp dword [potions],0
    jle .none
    dec dword [potions]
    mov eax,[hp]
    cmp eax,[maxhp]
    jge .full
    add eax,20
    cmp eax,[maxhp]
    jle .save
    mov eax,[maxhp]
.save:
    mov [hp],eax
    mov ecx,potionused
    call print_string
    ret
.full:
    mov ecx,fullhealth
    call print_string
    ret
.none:
    mov ecx,no_potions
    call print_string
    ret

explore_dungeon:
    mov eax,[room]
    cmp eax,1
    je .goblin
    cmp eax,2
    je .treasure
    cmp eax,3
    je .dragon
    ret
.goblin:
    mov ecx,goblinart
    call print_string
    mov dword [enemyhp],30
    mov dword [enemydmg],10
    call battle_enemy
    cmp eax,1
    jne .end
    mov dword [room],2
    ret
.treasure:
    mov ecx,chestart
    call print_string
.ask_chest:
    mov ecx,chestmenu
    call print_string
    call read_number
    jc .bad_chest
    cmp eax,1
    je .open
    cmp eax,2
    je .leave
.bad_chest:
    mov ecx,invalid
    call print_string
    jmp .ask_chest
.open:
    add dword [gold],50
    mov ecx,gotgold
    call print_string
    jmp .next_room
.leave:
    mov ecx,leftgold
    call print_string
.next_room:
    mov dword [room],3
.end:
    ret
.dragon:
    mov ecx,dragonart
    call print_string
    mov dword [enemyhp],60
    mov dword [enemydmg],15
    call battle_enemy
    cmp eax,1
    jne .end
    call display_game_result
    jmp exit_program

; EAX result: 1=enemy defeated, 0=ran away; loss exits game
battle_enemy:
    mov dword [defending],0
.turn:
    mov ecx,healthlabel
    call print_string
    mov eax,[hp]
    call print_number
    call print_newline
    mov ecx,enemyhealthlabel
    call print_string
    mov eax,[enemyhp]
    call print_number
    call print_newline
    mov ecx,combatmenu
    call print_string
    call read_number
    jc .invalid
    cmp eax,1
    je .attack
    cmp eax,2
    je .defend
    cmp eax,3
    je .potion
    cmp eax,4
    je .run
.invalid:
    mov ecx,invalid
    call print_string
    jmp .turn
.attack:
    mov ecx,hitmsg
    call print_string
    mov eax,[power]
    sub [enemyhp],eax
    cmp dword [enemyhp],0
    jle .win
    jmp .retaliate
.defend:
    mov ecx,defendmsg
    call print_string
    mov dword [defending],1
    jmp .retaliate
.potion:
    call use_potion
    jmp .turn
.run:
    mov ecx,ran
    call print_string
    xor eax,eax
    ret
.retaliate:
    mov eax,[enemydmg]
    cmp dword [defending],1
    jne .damage
    sub eax,5
    jge .damage
    xor eax,eax
.damage:
    mov dword [defending],0
    mov ecx,enemyhit
    call print_string
    push eax
    call print_number
    call print_newline
    pop eax
    sub [hp],eax
    cmp dword [hp],0
    jg .turn
    mov dword [hp],0
    call display_game_result
    jmp exit_program
.win:
    mov dword [enemyhp],0
    mov ecx,enemydead
    call print_string
    mov eax,1
    ret

display_game_result:
    cmp dword [hp],0
    jle .loss
    mov ecx,victory
    call print_string
    mov ecx,namebuf
    call print_string
    call print_newline
    mov ecx,victory2
    call print_string
    mov ecx,goldlabel
    call print_string
    mov eax,[gold]
    call print_number
    call print_newline
    mov ecx,healthlabel
    call print_string
    mov eax,[hp]
    call print_number
    call print_newline
    ret
.loss:
    mov ecx,gameover
    call print_string
    ret

exit_program:
    mov ecx,bye
    call print_string
    mov eax,1
    xor ebx,ebx
    int 0x80
