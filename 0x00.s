.data
	matrix: .space 1296	 #m e max 18,n e max 18 si n*m*4=18*18*4=1296
	columnIndex: .space 4
	lineIndex: .space 4
	m: .space 4	# m = numarul de linii
	n: .space 4	# n = numarul de coloane
	p: .space 4	# p = numarul celulelor vii (nr perechi de citit)
	pindex: .space 4	# pindex = contor pentru citirea perechilor
	left: .space 4	# left = linia pe care e celula vie
	right: .space 4	# right = coloana pe care e celula vie
	k: .space 4	# k = numarul de evolutii de urmarit
	m_bord: .long 0 # m_bord = numar linii pentru matricea bordata
	n_bord: .long 0 # n_bord = numar coloane pentru matricea bordata
	m_unu: .long 0 
	n_unu: .long 0 
	suma_vecini: .space 4
	bord_matrix: .space 1600 # copie_matrix = matricea bordata cu 0 pe care o vom prelucra k evolutii
	copie_matrix: .space 1600
	left_b : .long 0	# left_b = linia pe care se afla celula vie in matricea bordata
	right_b: .long 0 	# right_b = coloana pe care se afla celula vie in matricea bordata
	lineAbove: .space 4
	lineBelow: .space 4
	columnLeft: .space 4
	columnRight: .space 4
	element_curent: .space 4
	formatScanf: .asciz "%d"
	formatPrintf: .asciz "%d "
	newLine: .asciz "\n"
.text

.global main

main:
	pushl $m
	pushl $formatScanf
	call scanf		#citesc m = numarul de linii
	popl %ebx
	popl %ebx
	
	
	pushl $n
	pushl $formatScanf
	call scanf		#citesc n = numarul de coloane
	popl %ebx
	popl %ebx
	
	pushl $p
	pushl $formatScanf
	call scanf		#citesc p = numarul de celule vii
	popl %ebx
	popl %ebx
	
	# inainte sa citesc cele p perechi, stabilesc dimensiunile pentru copie_matrix
	
	movl m, %eax
	movl %eax, m_bord
	addl $2, m_bord
	
	movl n, %eax
	mov %eax, n_bord
	addl $2, n_bord
	
	xor %eax, %eax
	
	movl m, %eax
	movl %eax, m_unu
	incl m_unu
	
	xor %eax, %eax
	
	movl n, %eax
	movl %eax, n_unu
	incl n_unu
	
	xor %eax, %eax
	
	
	# urmeaza sa citim cele p perechi de coordonate left si right prin simularea unui for
	# for ul va merge in functie de pindex
	# dupa ce citim coordonatele,inainte de a trece la urmatoarele
	# punem 1 in matrice la pozitia matrix[left][right]
	
	movl $0, pindex
	jmp et_for_p_celule_vii
	
et_for_p_celule_vii:

	movl pindex, %ecx
	cmp %ecx, p
	je et_k_citire
	
	pushl $left
	pushl $formatScanf
	call scanf		#citesc left = coordonata pentru linie a unei celule vii
	popl %ebx
	popl %ebx
	
	pushl $right
	pushl $formatScanf
	call scanf		#citesc right = coordonata pentru coloana a unei celule vii
	popl %ebx
	popl %ebx
	
	# stabilim coordonatele celulei vii in bord_matrix
	
	movl left, %eax
	movl %eax, left_b
	incl left_b
	
	movl right, %eax
	movl %eax, right_b
	incl right_b
	
	xor %eax, %eax
	
	# trebuie sa completez bord_matrix[left_b][right_b] = 1
	
	movl left_b, %eax
	movl $0, %edx
	mull n_bord
	addl right_b, %eax	# %eax := %eax * left + right
	
	lea bord_matrix, %edi	
	movl $1, (%edi, %eax, 4)
	
	incl pindex
	jmp et_for_p_celule_vii

et_k_citire:
	pushl $k
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	jmp et_k_evolutie
	
et_k_evolutie:

	movl k, %eax
	cmp $0, %eax
	je et_matrix
	
	decl k
			
	movl $1, lineIndex
	for_lines_evol:
		mov lineIndex, %ecx
		cmp %ecx, m_unu
		je et_copiere_evolutie
		
		movl $1, columnIndex
		for_columns_evol:
			movl columnIndex, %ecx
			cmp %ecx, n_unu
			je cont_evol
		
			movl $0, suma_vecini
			
			movl lineIndex, %eax
			movl %eax, lineAbove
			decl lineAbove
			xor %eax, %eax
			
			movl lineIndex, %eax
			movl %eax, lineBelow
			incl lineBelow
			xor %eax, %eax
			
			movl columnIndex, %eax
			movl %eax, columnLeft
			decl columnLeft
			xor %eax, %eax
			
			movl columnIndex, %eax
			movl %eax, columnRight
			incl columnRight
			xor %eax, %eax
			
			
			#adaug la suma vecini elem a00
			
			movl lineAbove, %eax
			movl $0, %edx
			mull n_bord
			addl columnLeft, %eax	
		
			lea bord_matrix, %edi
			movl (%edi, %eax, 4), %ebx
		
			addl %ebx, suma_vecini
			
			#adaug la suma vecini elem a01
			
			movl lineAbove, %eax
			movl $0, %edx
			mull n_bord
			addl columnIndex, %eax	
		
			lea bord_matrix, %edi
			movl (%edi, %eax, 4), %ebx
		
			addl %ebx, suma_vecini
			
			
			#adaug la suma vecini elem a02
			
			movl lineAbove, %eax
			movl $0, %edx
			mull n_bord
			addl columnRight, %eax	
		
			lea bord_matrix, %edi
			movl (%edi, %eax, 4), %ebx
		
			addl %ebx, suma_vecini
			
			
			#adaug la suma vecini elem a10
			
			movl lineIndex, %eax
			movl $0, %edx
			mull n_bord
			addl columnLeft, %eax	
		
			lea bord_matrix, %edi
			movl (%edi, %eax, 4), %ebx
		
			addl %ebx, suma_vecini
			
			
			#adaug la suma vecini elem a12
			
			movl lineIndex, %eax
			movl $0, %edx
			mull n_bord
			addl columnRight, %eax	
		
			lea bord_matrix, %edi
			movl (%edi, %eax, 4), %ebx
		
			addl %ebx, suma_vecini
			
			
			#adaug la suma vecini elem a20
			
			movl lineBelow, %eax
			movl $0, %edx
			mull n_bord
			addl columnLeft, %eax	
		
			lea bord_matrix, %edi
			movl (%edi, %eax, 4), %ebx
		
			addl %ebx, suma_vecini
			
			
			
			#adaug la suma vecini elem a21
			
			movl lineBelow, %eax
			movl $0, %edx
			mull n_bord
			addl columnIndex, %eax	
		
			lea bord_matrix, %edi
			movl (%edi, %eax, 4), %ebx
		
			addl %ebx, suma_vecini
			
			
			#adaug la suma vecini elem a22
			
			movl lineBelow, %eax
			movl $0, %edx
			mull n_bord
			addl columnRight, %eax	
		
			lea bord_matrix, %edi
			movl (%edi, %eax, 4), %ebx
		
			addl %ebx, suma_vecini
			
			
			movl lineIndex, %eax
			movl $0, %edx
			mull n_bord
			addl columnIndex, %eax	
		
			lea bord_matrix, %edi
			movl (%edi, %eax, 4), %ebx
			movl %ebx, element_curent
			
			xor %ebx, %ebx
			
			cmpl $1, element_curent
			je et_conditii_eval_unu
			
			cmpl $0, element_curent
			je et_conditii_eval_zero
			
			completare_zero:
				lea copie_matrix, %edi	
				movl $0, (%edi, %eax, 4)
				jmp cont_evol_linii
				
			completare_unu:
				lea copie_matrix, %edi	
				movl $1, (%edi, %eax, 4)
				jmp cont_evol_linii
			
			
			cont_evol_linii:	
				incl columnIndex
				jmp for_columns_evol
	
	cont_evol:	
		incl lineIndex
		jmp for_lines_evol
	
		
	
	
	
et_conditii_eval_unu:
	cmpl $1, suma_vecini
	jbe completare_zero
	
	cmpl $2, suma_vecini
	je completare_unu
	
	cmpl $3, suma_vecini
	je completare_unu
	
	cmpl $4, suma_vecini
	jae completare_zero
	
	
	
et_conditii_eval_zero:
	cmpl $3, suma_vecini
	je completare_unu
	
	jmp completare_zero


et_copiere_evolutie:

	movl $1, lineIndex
	for_lines_copiere:
		mov lineIndex, %ecx
		cmp %ecx, m_unu
		je et_k_evolutie
	
		movl $1, columnIndex
		for_columns_copiere:
			movl columnIndex, %ecx
			cmp %ecx, n_unu
			je cont_copiere
		
			movl lineIndex, %eax
			movl $0, %edx
			mull n_bord
			addl columnIndex, %eax	
		
			lea copie_matrix, %edi
			movl (%edi, %eax, 4), %ebx
			
			lea bord_matrix, %edi
			movl %ebx, (%edi, %eax, 4)		
		
			incl columnIndex
			jmp for_columns_copiere
	
	cont_copiere:	
		incl lineIndex
		jmp for_lines_copiere


et_matrix:

	movl $1, lineIndex
	for_lines_matrix:
	
		mov lineIndex, %ecx
		cmp %ecx, m_unu
		je et_afis
		
		movl lineIndex, %eax
		movl %eax, left
		decl left
		xor %eax, %eax
		
		movl $1, columnIndex
		for_columns_matrix:
			movl columnIndex, %ecx
			cmp %ecx, n_unu
			je cont_matrix
		
			movl columnIndex, %eax
			movl %eax, right
			decl right
			xor %eax, %eax
			
			movl lineIndex, %eax
			movl $0, %edx
			mull n_bord
			addl columnIndex, %eax	
		
			lea copie_matrix, %edi
			movl (%edi, %eax, 4), %ebx
			
			movl left, %eax
			movl $0, %edx
			mull n
			addl right, %eax
			
			lea matrix, %edi
			movl %ebx, (%edi, %eax, 4)
				
			incl columnIndex
			jmp for_columns_matrix
	
	cont_matrix:	
		incl lineIndex
		jmp for_lines_matrix	
	
	
et_afis:	
	movl $0, lineIndex
	for_lines_afis:
		mov lineIndex, %ecx
		cmp %ecx, m
		je et_exit
	
		movl $0, columnIndex
		for_columns_afis:
			movl columnIndex, %ecx
			cmp %ecx, n
			je cont_afis
		
			movl lineIndex, %eax
			movl $0, %edx
			mull n
			addl columnIndex, %eax	
		
			lea matrix, %edi
			movl (%edi, %eax, 4), %ebx
		
			pushl %ebx
			pushl $formatPrintf
			call printf
			popl %ebx
			popl %ebx
		
			pushl $0
			call fflush
			popl %ebx
			
			incl columnIndex
			jmp for_columns_afis
	
	cont_afis:	
		movl $4, %eax
		movl $1, %ebx
		movl $newLine, %ecx
		movl $2, %edx
		int $0x80
	
		incl lineIndex
		jmp for_lines_afis
		
et_exit:
	movl $1, %eax
	movl $0, %ebx
	int $0x80