.data
stringa: .space 101 #alloco spazio vuoto riservato alla stringa
SI: .asciiz "SI" #usato per stampare SI
NO: .asciiz "NO" #usato per stampare NO
grfa: .asciiz "{" 
grfc: .asciiz "}"
quada: .asciiz "["
quadc: .asciiz "]"
tonda: .asciiz "("
tondc: .asciiz ")"
angoa: .asciiz "<"
angoc: .asciiz ">"

.text
.globl main

main:
	#input stringa
	li $v0,8
	la $a0,stringa
	li $a1,101
	syscall
	#inizializzo i parametri per la ricorsione	
	li $a3,1
	li $a1,'\n'
	jal riconosci
	#tornato dalla ricorsione stampa SI\NO ed esce
	beqz $a3,false
	li $v0,4
	la $a0,SI
	syscall
	li $v0,10
	syscall
false:
	li $v0,4
	la $a0,NO
	syscall
	li $v0,10
	syscall
	
riconosci:#$a0=stringa,$a1=simbolodacercare,$a2=simbolocorrente,$a3=verità corrente,$t9=simbolodaconfrontare
#Se verità=false ritorno alle funzioni ricorsive chiamanti la verità senza computare altro
		beqz,$a3,retfalse
#Carico il primo carattere della stringa e memorizzo nello stack i valori dei parametri
		lb $a2,0($a0) #carica carattere posizione 0	
		subiu $sp,$sp,8
		sw $a1,4($sp)
		sw $ra,0($sp)

#CASOBASE:Se la stringa è vuota e il carattere da cercare e il terminatore \n return true altrimenti return false alle funzioni chiamanti
isempty:	li $t9,'\n'
		bne $a2,$t9,istonda #se non ho raggiunto la fine verifico di che simbolo si tratta
		bne $a2,$a1,retfalse#se nonostante sia arrivato alla fine non sto cercando \n allora ho parentesi aperte quindi return false
		j rettrue #altrimenti return true
#se e simbolo aperto inserisco in $a1 la corrispondente chisura e vado a fare il push nello stack
istonda:	lb $t9,tonda
		bne $a2,$t9,isgrfa
		lb $a1,tondc
		j isopen	
isgrfa:		lb $t9,grfa     
		bne $a2,$t9,isquada
		lb $a1,grfc
		j isopen
isquada:	lb $t9,quada
		bne $a2,$t9,isangoa
		lb $a1,quadc
		j isopen
isangoa:	lb $t9,angoa
		bne $a2,$t9,isclosed #se non e il terminatore o un simbolo aperto e un simbolo chiuso
		lb $a1,angoc
		j isopen

isopen:
#predispongo la chiamata della ricorsione caricando nei registri i valori presi dallo stack 
#e quindi aggiornando l'indice per quest'ultimo. Quando ritorno vorrò vedere se siamo ritornati al caso base e che la condizione non sia falsa..

		add,$a0,$a0,1#stringa(1,fine)

		jal riconosci
		lw $ra,0($sp)
		lw $a1,4($sp)
		addiu $sp,$sp,8		
		j riconosci
								
isclosed:	
#effettuto il pop dallo stack gestendone l'indice e verifico che il simbolo chiuso sia quello previsto e ritornando poi alla funzione chiamante altrimenti ritorno falso alla fun chiamante
		lw $ra,0($sp)
		lw $a1,4($sp)
		addiu $sp,$sp,8
		bne $a2,$a1,retfalse#Se simbolodacercare != simbolocorrente ritorno falso altrimenti vado avanti alla stringa rimanente
		add,$a0,$a0,1#stringa(1,fine)
		j rettrue

#ritorni 0,1 per le funzione chiamanti
rettrue:	li $a3,1 #a3 contiene 1 ossia true
		jr $ra
retfalse:	li $a3,0 #a3 contiene 0 ossia false
		jr $ra
