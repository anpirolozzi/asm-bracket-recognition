Riconoscimento di parentesi

Bisogna riconoscere se in una stringa di testo contenente solo parentesi aperte e chiuse le parentesi sono corrette, ovvero:
una stringa di 0 caratteri è un gruppo di parentesi corretto
un gruppo corretto seguito da altri gruppi corretti è corretto
per ogni parentesi aperta ci deve essere la corrispondente parentesi chiusa
tra due parentesi è contenuto un gruppo di parentesi corretto
I caratteri che dovete considerare come parentesi sono:
parentesi aperte: { [ ( <
parentesi chiuse: } ] ) >
Realizzate la funzione ricorsiva riconosci che:
riceve come argomento una stringa di testo e tutti gli altri argomenti che ritenete necessari
riconosce se le parentesi sono corrette oppure no
torna 0 (FALSE) o 1 (TRUE) per indicare il risultato del test
Il main deve:
leggere una stringa lunga al massimo 100 caratteri
chiamare la funzione riconosci
stampare SI oppure NO a seconda del risultato del test
uscire
Esempi:
Input: {[][(<>([])<{}[]>)<>]}
Output: SI
Input: {[][(<>(])<{}[]>)<>]}
Output: NO (manca una parentesi aperta)
Input : {[][(<>([])<{}[>)<>]}
Output: NO (manca una parentesi chiusa)
