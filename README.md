# Conway's Game of Life -- Assembly x86

## Overview

This program is an implementation of the **Game of Life**, developed for the Computer Systems Architecture course using assembly language. The Game of Life is a cellular automaton created by mathematician John Conway. The program simulates the evolution of a grid of cells, where each cell can be either alive or dead, and the next state of the grid depends on the number of living neighbors each cell has.

The project was divided into three distinct problems, and I completed the first and third problems, which are closely related. The first problem involved creating and running a simulator for the Game of Life, while the third problem introduced improvements and optimizations based on the first.

The implementation uses a two-dimensional matrix, which can be customized by the user in terms of size (number of rows `m` and columns `n`) and the number of initially "alive" cells. The user can also set the number of generations (`k`) for which the game will be simulated.

## Features

- **Dynamic Grid Size**: The user can specify the number of rows (`m`) and columns (`n`).
- **Initial Configuration**: The user can enter the coordinates of the initially "alive" cells.
- **Generations Simulation**: The user can simulate `k` generations, with each generation calculated based on the Game of Life rules.
- **Grid Output**: After the simulation, the final configuration of the grid is displayed.

## How it Works

### Input

1. **m**: Number of grid rows.
2. **n**: Number of grid columns.
3. **p**: Number of initially "alive" cells.
4. **p coordinate pairs**: Coordinates of the initially alive cells (row, column).
5. **k**: Number of generations to simulate.

### Output

After running the program, the final state of the grid (after `k` generations) will be displayed. The grid cells are represented as `1` (alive) and `0` (dead).

### Rules

The program implements the standard Game of Life rules:
- A cell remains "alive" if it has exactly 2 or 3 living neighbors.
- A cell dies if it has fewer than 2 or more than 3 living neighbors.
- A dead cell with exactly 3 living neighbors becomes alive in the next generation.

### Steps

1. **Grid Initialization**: The grid is set based on the specified dimensions and initial live cell positions.
2. **Generations Simulation**: The simulation runs for `k` generations, updating the state of each cell based on its neighbors.
3. **Displaying Final Grid**: After `k` generations, the final state of the grid is displayed.

## Code Structure

### Data Section

- `matrix`: Space for the main grid.
- `bord_matrix`: Space for the bordered matrix.
- `copie_matrix`: Space for a copy of the matrix, used to store new values during the simulation.
- Variables to store dimensions (`m`, `n`), number of initial live cells (`p`), and number of generations (`k`).
- Other variables for managing coordinates, row and column indices, and neighbors.

### Code Section

- **Main Program**: Handles input for grid dimensions, initial live cells, and the number of generations to simulate.
- **Simulation**: Logic for calculating the new state of the grid, using loops to traverse each cell and count neighbors.
- **Output**: Displays the final state of the grid after all generations.

### File I/O

- The program reads data from an input file (`in.txt`) and writes the result to an output file (`out.txt`).
- The `in.txt` file contains grid dimensions, initial live cell coordinates, and the number of generations.
- The program writes the final grid to `out.txt`.

## How to Run the Program

### Compilation

1. Write the input data into a file named `in.txt` (example below).
2. Assemble and link the program using your assembler and linker:

```bash
nasm -f elf32 game_of_life.asm -o game_of_life.o
ld -m elf_i386 -s -o game_of_life game_of_life.o
```

### Example Input File (`in.txt`)

```plaintext
5 5 3
1 1
2 2
3 3
3
```

This input defines:
- A 5x5 grid (`m = 5`, `n = 5`).
- 3 initial live cells at coordinates (1, 1), (2, 2), and (3, 3).
- The simulation will run for 3 generations.

### Running the Program

To execute the program:

```bash
./game_of_life
```

## Technologies and Concepts Used

- **Low-Level Programming** - Optimizing memory access and reducing latencies.
- **Matrix Processing Algorithms** - Applying transition rules for cells.
- **Efficient Data Structures** - Fast storage and access for the simulation grid.

## Additional Information

- The program uses **fscanf** and **fopen** to read from files and **fprintf** to write output.
- It utilizes assembly-level control structures (loops, conditional instructions) to simulate generations and update the grid.

___

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
