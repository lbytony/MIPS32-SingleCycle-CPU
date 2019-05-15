addu $8, $0, 0x8		#$s8: 	0x8
ori $16, $0, 1			#$16: 	0x1
ori $17, $0, 3			#$8: 	0x3
ori $8, $0, 0x2			#$8: 	0x2
ori $12, $0,0xabab		#$12:	0xabab
lui $13, 10			#$13:	0xa
start:addu $4, $0, $16		#$4:	0x1
addu $5, $0,$8			#$5:	0x2
jal newadd
addu $16, $0, $2		#$16:	3
subu $17,$17,$8			#$17: 	0xffff fffe
beq $16, $17, start		#false
ori $8, $0, 1			#$8: 	0x1
addiu $24,$0,0x7fffffff		#$24:	0x7fffffff
addiu $9,$24,3			#$9:	0x80000002
addiu $10,$24,5			#$10: 	0x80000004
addu $0,$0,$0
start2:sw $9, 0($8)
lw $14, 0($8)			#$14: 	0x80000002
sw $10,4($8)
lw $15,4($8)			#$15:	0x80000004
sw $4, -4($8)
lw $18, -4($8)			#$18:	0x00000001
addu $4,$0,$8			#$4:	0x1
addu $5,$0,$9			#$5:	0x80000002
jal newadd			#$2:	0x80000003
slt $25,$10,$8			#$25:	0
beq $25, $0,end2		#true
slt $20,$12,$4
beq $20, $0, end1
lui $12, 65535
end1:ori $0, $0,1
lui $19, 0xefef
addiu $3,$0,0xababcdcd
start3:addiu $4, $3, 2
addi $23, $3, 5
jal newadd
addu $8, $0, $2
addu $4, $0, $8
addu $5, $0, $9
jal newadd
addu $9, $0, $2
addu $9, $8, $0
lui $10, 0x69
beq $8, $9, start4
beq $0, $0, start3
start4:j end
newadd:addu $2, $4, $5		#$2: 	3
addi $0,$12,0x7823		#$0:	0
jr $31
end2:addi $25,$0,0x1234		#25:	0x1234
end: