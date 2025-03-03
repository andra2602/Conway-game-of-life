# Conway game of life -- Assembly x86

## Prezentare generală

Acest program reprezintă o implementare a **Jocului Vieții**, realizată în cadrul materiei Arhitectura Sistemelor de Calcul, folosind limbajul de asamblare. 
Jocul Vieții este un automat celular creat de matematicianul John Conway. Programul simulează evoluția unei grile de celule, unde fiecare celulă poate fi fie vie, fie moartă, iar următoarea stare a grilei depinde de numărul de vecini vii ai fiecărei celule.

Proiectul a fost împărțit în trei probleme distincte, iar eu am realizat prima și a treia problemă, acestea fiind strâns corelate între ele. Prima problemă a presupus crearea și rularea unui simulator pentru Game of Life, iar a treia problemă a adus îmbunătățiri și optimizări pe baza celei dintâi.

Implementarea folosește o matrice bidimensională, care poate fi ajustată de utilizator în funcție de dimensiuni (numărul de rânduri `m` și coloane `n`) și numărul de celule inițial "vii". Utilizatorul poate de asemenea seta numărul de generații (`k`) pentru care se va simula jocul.

## Funcționalități

- **Dimensiune dinamică a grilei**: Utilizatorul poate specifica numărul de rânduri (`m`) și coloane (`n`).
- **Configurație inițială**: Utilizatorul poate introduce coordonatele celulelor inițial "vii".
- **Simularea generațiilor**: Utilizatorul poate simula `k` generații, fiecare generație fiind calculată pe baza regulilor Jocului Vieții.
- **Ieșire matrice**: După simulare, este afișată configurația finală a grilei.

## Cum funcționează

### Intrare

1. **m**: Numărul de rânduri ale grilei.
2. **n**: Numărul de coloane ale grilei.
3. **p**: Numărul de celule inițial "vii".
4. **p perechi de coordonate**: Coordonatele celulelor vii inițial (stânga, dreapta), unde `stânga` este rândul și `dreapta` este coloana.
5. **k**: Numărul de generații de simulare.

### Ieșire

După rularea programului, starea finală a grilei (după `k` generații) va fi afișată. Celulele grilei sunt afișate ca `1` (vie) și `0` (moartă).

### Reguli

Programul implementează regulile standard ale Jocului Vieții:
- O celulă este "vie" dacă are exact 2 sau 3 vecini vii.
- O celulă este "moartă" dacă are mai puțin de 2 sau mai mult de 3 vecini vii.
- O celulă moartă cu exact 3 vecini vii devine vie în următoarea generație.

### Pași

1. **Inițializarea grilei**: Pe baza inputului, grila este setată cu dimensiunile specificate și cu pozițiile celulelor vii inițiale.
2. **Simularea generațiilor**: Simularea se desfășoară pentru `k` generații, actualizând starea fiecărei celule pe baza vecinilor săi.
3. **Afișarea grilei finale**: După `k` generații, programul afișează grila finală.

## Structura codului

### Secțiunea de date

- `matrix`: Spațiu pentru grila principală.
- `bord_matrix`: Spațiu pentru matricea cu margini (borduri).
- `copie_matrix`: Spațiu pentru o copie a matricei, utilizată pentru a stoca noile valori în timpul simulării.
- Variabile pentru a stoca dimensiunile (`m`, `n`), numărul de celule vii inițial (`p`) și numărul de generații (`k`).
- Alte variabile pentru gestionarea coordonatelor, indicilor de rând și coloană și vecinilor.

### Secțiunea de cod

- **Programul principal**: Gestionează intrarea dimensiunilor grilei, celulele vii inițial și numărul de generații de simulat.
- **Simularea**: Logica pentru calcularea noii stări a grilei este implementată cu ajutorul buclelor care parcurg fiecare celulă și numără vecinii săi.
- **Ieșirea**: Starea finală a grilei după toate generațiile este afișată.

### I/O de fișiere

- Programul citește datele dintr-un fișier de intrare (`in.txt`) și scrie rezultatul într-un fișier de ieșire (`out.txt`).
- Fișierul `in.txt` conține dimensiunile grilei, coordonatele celulelor vii inițial și numărul de generații.
- Programul scrie grila finală în fișierul `out.txt`.

## Cum să rulezi programul

### Compilare

1. Scrie datele de intrare într-un fișier denumit `in.txt` (exemplu mai jos).
2. Asamblează și leagă programul folosind assemblerul și linkerul tău:
    ```bash
    nasm -f elf32 game_of_life.asm -o game_of_life.o
    ld -m elf_i386 -s -o game_of_life game_of_life.o
    ```

### Exemplu fișier de intrare (`in.txt`)

```plaintext
5 5 3
1 1
2 2
3 3
3
```

Acest input definește:
- O grilă de 5x5 (`m = 5`, `n = 5`).
- 3 celule vii inițiale la coordonatele (1, 1), (2, 2) și (3, 3).
- Se vor simula 3 generații.

### Rularea programului

Pentru a executa programul:
```bash
./game_of_life
```
## Tehnologii si concepte utilizate
- Programare de nivel jos - Optimizarea accesului la memorie și reducerea latențelor.
- Algoritmi pentru procesare matricială - Aplicarea regulilor de tranziție pentru celule.
- Structuri de date eficiente - Stocarea și accesarea rapidă a grilei de simulare.
  
## Informații suplimentare

- Programul folosește **fscanf** și **fopen** pentru a citi din fișiere și **fprintf** pentru a scrie ieșirea.
- Folosește structuri de control la nivel de asamblare (bucle, instrucțiuni condiționale) pentru a simula generațiile și pentru a actualiza grila.
