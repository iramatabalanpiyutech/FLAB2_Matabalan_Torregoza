BITS 32
section .data
welcome db 10,'=======================================',10,'       THE MYSTIC ZODIAC ORACLE',10,'=======================================',10,'            *       *',10,'         *     /\     *',10,'              /  \',10,'         *   /____\   *',10,'             |    |',10,'             |____|',10,'       DISCOVER YOUR DESTINY!',10,'=======================================',10,0
askname db 'Enter your name: ',0
askmonth db 'Enter birth month (1-12): ',0
askday db 'Enter birth day (1-31): ',0
invalidmonth db 'Invalid month. Please try again.',10,0
invaliddate db 'Invalid date. Please try again.',10,0
invalidnumber db 'Please enter digits only.',10,0
hello db 10,'Welcome, ',0
excl db '!',10,0
zhead db 10,'=======================================',10,'         YOUR ZODIAC SIGN',10,'=======================================',10,0
zlabel db 'Zodiac Sign: ',0
elabel db 'Element: ',0
slabel db 'Symbol: ',0
plabel db 'Personality: ',0
menu db 10,'========== HOROSCOPE MENU ==========',10,'[1] Love and Relationships',10,'[2] Career and Studies',10,'[3] Health and Wellness',10,'[4] Lucky Number and Color',10,'[5] View Zodiac Information',10,'[6] Exit',10,'Enter your choice: ',0
badchoice db 'Invalid selection. Please try again.',10,0
again db 'Return to menu? (Y/N): ',0
bye db 10,'Thank you for visiting the Mystic Zodiac Oracle!',10,0
lovehead db 10,'LOVE HOROSCOPE',10,0
careerhead db 10,'CAREER HOROSCOPE',10,0
healthhead db 10,'HEALTH HOROSCOPE',10,0
luckyhead db 10,'LUCKY NUMBER AND COLOR',10,0
love db 'A kind conversation may brighten your relationships today.',10,0
career db 'Your creativity and focus will help you solve a challenge.',10,0
health db 'Take a short break, drink water, and care for yourself.',10,0
luckytext db 'Lucky Number: ',0
colortext db 'Lucky Color: ',0
newline db 10,0
artfire db '       /\',10,'      /  \',10,'     / /\ \',10,'     \_||_/',10,0
artearth db '      ______',10,'     / ____ \',10,'    /_/    \_\',10,'      |__|',10,0
artair db '      ~ ~ ~ ~',10,'    ~  ~  ~  ~',10,'      ~ ~ ~ ~',10,0
artwater db '       /\',10,'      /  \',10,'     /    \',10,'     \____/',10,0
sign0 db 'ARIES',10,0
sign1 db 'TAURUS',10,0
sign2 db 'GEMINI',10,0
sign3 db 'CANCER',10,0
sign4 db 'LEO',10,0
sign5 db 'VIRGO',10,0
sign6 db 'LIBRA',10,0
sign7 db 'SCORPIO',10,0
sign8 db 'SAGITTARIUS',10,0
sign9 db 'CAPRICORN',10,0
sign10 db 'AQUARIUS',10,0
sign11 db 'PISCES',10,0
fire db 'Fire',10,0
earth db 'Earth',10,0
air db 'Air',10,0
water db 'Water',10,0
sym0 db 'Ram',10,0
sym1 db 'Bull',10,0
sym2 db 'Twins',10,0
sym3 db 'Crab',10,0
sym4 db 'Lion',10,0
sym5 db 'Maiden',10,0
sym6 db 'Scales',10,0
sym7 db 'Scorpion',10,0
sym8 db 'Archer',10,0
sym9 db 'Sea-Goat',10,0
sym10 db 'Water Bearer',10,0
sym11 db 'Fish',10,0
person0 db 'Bold, energetic, adventurous.',10,0
person1 db 'Patient, loyal, dependable.',10,0
person2 db 'Curious, adaptable, expressive.',10,0
person3 db 'Caring, intuitive, protective.',10,0
person4 db 'Confident, creative, courageous.',10,0
person5 db 'Practical, thoughtful, organized.',10,0
person6 db 'Fair, charming, cooperative.',10,0
person7 db 'Passionate, determined, resourceful.',10,0
person8 db 'Optimistic, honest, adventurous.',10,0
person9 db 'Disciplined, ambitious, responsible.',10,0
person10 db 'Independent, inventive, friendly.',10,0
person11 db 'Compassionate, imaginative, gentle.',10,0
color0 db 'Red',10,0
color1 db 'Green',10,0
color2 db 'Yellow',10,0
color3 db 'Silver',10,0
color4 db 'Gold',10,0
color5 db 'Navy Blue',10,0
color6 db 'Pink',10,0
color7 db 'Maroon',10,0
color8 db 'Purple',10,0
color9 db 'Brown',10,0
color10 db 'Turquoise',10,0
color11 db 'Sea Green',10,0
signs dd sign0,sign1,sign2,sign3,sign4,sign5,sign6,sign7,sign8,sign9,sign10,sign11
symbols dd sym0,sym1,sym2,sym3,sym4,sym5,sym6,sym7,sym8,sym9,sym10,sym11
personalities dd person0,person1,person2,person3,person4,person5,person6,person7,person8,person9,person10,person11
colors dd color0,color1,color2,color3,color4,color5,color6,color7,color8,color9,color10,color11
elements dd fire,earth,air,water,fire,earth,air,water,fire,earth,air,water
arts dd artfire,artearth,artair,artwater,artfire,artearth,artair,artwater,artfire,artearth,artair,artwater
maxdays dd 31,28,31,30,31,30,31,31,30,31,30,31
; Index by birth month (January = 0); boundary is the day new sign begins.
firstsign dd 9,10,11,0,1,2,3,4,5,6,7,8
boundary dd 20,19,21,20,21,21,23,23,23,23,22,22
lucky dd 9,6,5,2,1,4,7,8,3,10,11,12
section .bss
namebuf resb 128
inputbuf resb 64
month resd 1
day resd 1
zodiac resd 1
choice resd 1
section .text
global _start
_start:
    call display_welcome
    call get_user_info
    call determine_zodiac
    mov ecx,hello
    call print_string
    mov ecx,namebuf
    call print_string
    mov ecx,excl
    call print_string
    call display_zodiac_art
.menu_loop:
    call display_menu
    mov ecx,inputbuf
    mov edx,64
    call read_line
    mov ecx,inputbuf
    call parse_number
    jc .invalid
    mov [choice],eax
    cmp eax,6
    je exit_program
    cmp eax,1
    jl .invalid
    cmp eax,5
    jg .invalid
    cmp eax,5
    je .info
    call show_horoscope
    jmp .return_prompt
.info:
    call display_zodiac_art
.return_prompt:
    mov ecx,again
    call print_string
    mov ecx,inputbuf
    mov edx,64
    call read_line
    mov al,[inputbuf]
    cmp al,'Y'
    je .menu_loop
    cmp al,'y'
    je .menu_loop
    cmp al,'N'
    je exit_program
    cmp al,'n'
    je exit_program
    mov ecx,badchoice
    call print_string
    jmp .return_prompt
.invalid:
    mov ecx,badchoice
    call print_string
    jmp .menu_loop

; Print zero-terminated string from ECX. Preserve caller registers.
print_string:
    pushad
    mov esi,ecx
    xor edx,edx
.count:
    cmp byte [esi+edx],0
    je .write
    inc edx
    jmp .count
.write:
    mov eax,4
    mov ebx,1
    int 0x80
    popad
    ret

; Read a line, removing newline; ECX=buffer, EDX=capacity.
; Reads one byte at a time so long input cannot leak into next prompt.
read_line:
    pushad
    mov esi,ecx
    mov edi,edx
    dec edi
    xor ebp,ebp
.read:
    mov eax,3
    mov ebx,0
    mov ecx,input_char
    mov edx,1
    int 0x80
    cmp eax,1
    jne .done
    mov al,[input_char]
    cmp al,10
    je .done
    cmp al,13
    je .read
    cmp ebp,edi
    jae .read
    mov [esi+ebp],al
    inc ebp
    jmp .read
.done:
    mov byte [esi+ebp],0
    popad
    ret

; ECX points to decimal string; EAX=result, CF=1 for invalid.
parse_number:
    push ebx
    push esi
    push edx
    mov esi,ecx
    xor eax,eax
    cmp byte [esi],0
    je .bad
.next:
    movzx ebx,byte [esi]
    test bl,bl
    jz .good
    cmp bl,'0'
    jb .bad
    cmp bl,'9'
    ja .bad
    sub ebx,'0'
    mov edx,10
    mul edx
    test edx,edx
    jnz .bad
    add eax,ebx
    jc .bad
    inc esi
    jmp .next
.good:
    clc
    jmp .end
.bad:
    stc
.end:
    pop edx
    pop esi
    pop ebx
    ret

display_welcome:
    mov ecx,welcome
    call print_string
    ret

get_user_info:
    mov ecx,askname
    call print_string
    mov ecx,namebuf
    mov edx,128
    call read_line
.retry_month:
    mov ecx,askmonth
    call print_string
    mov ecx,inputbuf
    mov edx,64
    call read_line
    mov ecx,inputbuf
    call parse_number
    jc .bad_month
    mov [month],eax
    cmp eax,1
    jl .bad_month
    cmp eax,12
    jg .bad_month
    jmp .retry_day
.bad_month:
    mov ecx,invalidmonth
    call print_string
    jmp .retry_month
.retry_day:
    mov ecx,askday
    call print_string
    mov ecx,inputbuf
    mov edx,64
    call read_line
    mov ecx,inputbuf
    call parse_number
    jc .bad_day
    mov [day],eax
    call validate_birthdate
    cmp eax,1
    je .done
.bad_day:
    mov ecx,invaliddate
    call print_string
    jmp .retry_day
.done:
    ret

; EAX=1 valid, 0 invalid.
validate_birthdate:
    mov eax,[month]
    cmp eax,1
    jl .invalid
    cmp eax,12
    jg .invalid
    mov edx,[day]
    cmp edx,1
    jl .invalid
    mov ecx,[maxdays+eax*4-4]
    cmp edx,ecx
    jg .invalid
    mov eax,1
    ret
.invalid:
    xor eax,eax
    ret

; Determine zodiac from month base sign and the transition day.
determine_zodiac:
    mov ebx,[month]
    dec ebx
    mov eax,[firstsign+ebx*4]
    mov ecx,[day]
    cmp ecx,[boundary+ebx*4]
    jl .save
    inc eax
    cmp eax,12
    jl .save
    xor eax,eax
.save:
    mov [zodiac],eax
    ret

display_zodiac_art:
    mov ecx,zhead
    call print_string
    mov ebx,[zodiac]
    mov ecx,[arts+ebx*4]
    call print_string
    mov ecx,zlabel
    call print_string
    mov ebx,[zodiac]
    mov ecx,[signs+ebx*4]
    call print_string
    mov ecx,elabel
    call print_string
    mov ebx,[zodiac]
    mov ecx,[elements+ebx*4]
    call print_string
    mov ecx,slabel
    call print_string
    mov ebx,[zodiac]
    mov ecx,[symbols+ebx*4]
    call print_string
    mov ecx,plabel
    call print_string
    mov ebx,[zodiac]
    mov ecx,[personalities+ebx*4]
    call print_string
    ret

display_menu:
    mov ecx,menu
    call print_string
    ret

show_horoscope:
    mov eax,[choice]
    cmp eax,1
    je .love
    cmp eax,2
    je .career
    cmp eax,3
    je .health
    cmp eax,4
    je .lucky
    ret
.love:
    mov ecx,lovehead
    call print_string
    mov ecx,love
    call print_string
    ret
.career:
    mov ecx,careerhead
    call print_string
    mov ecx,career
    call print_string
    ret
.health:
    mov ecx,healthhead
    call print_string
    mov ecx,health
    call print_string
    ret
.lucky:
    mov ecx,luckyhead
    call print_string
    mov ecx,luckytext
    call print_string
    mov ebx,[zodiac]
    mov eax,[lucky+ebx*4]
    call print_number
    mov ecx,newline
    call print_string
    mov ecx,colortext
    call print_string
    mov ebx,[zodiac]
    mov ecx,[colors+ebx*4]
    call print_string
    ret

; Print unsigned integer EAX.
print_number:
    pushad
    mov edi,numberbuf+15
    mov byte [edi],0
    mov ebx,10
.next:
    xor edx,edx
    div ebx
    dec edi
    add dl,'0'
    mov [edi],dl
    test eax,eax
    jnz .next
    mov ecx,edi
    call print_string
    popad
    ret

exit_program:
    mov ecx,bye
    call print_string
    mov eax,1
    xor ebx,ebx
    int 0x80

section .bss
input_char resb 1
numberbuf resb 16
