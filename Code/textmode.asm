Initial:
lui $s7, 0x000D;       // ps2
and $s6, $s6, $zero;   // s6: char_ram pointer
and $s5, $s5, $zero;   // s5: row
and $s4, $s4, $zero;   // s4: col
and $s3, $s3, $zero;   // s3: stack pointer
addi $a0, $zero, 80;   // max of a line
addi $a1, $zero, 0;    // shift mode 0 or 1

Start:
lw $t7, 0($s7);        // get scan code of keyboard

addi $t4, $zero, 0;    // delay
addi $t3, $zero, 30000;
addi $t3, $t3, 30000;
addi $t3, $t3, 30000;
addi $t3, $t3, 30000;
addi $t3, $t3, 30000;
addi $t3, $t3, 30000;
addi $t3, $t3, 30000;
addi $t3, $t3, 30000;
Delay:
addi $t4, $t4, 1;
bne $t4, $t3, Delay;   // delay_end

beq $t7, $zero, Start; // polling

bne $a1, $zero, second;// if shift has been pushed
addi $t0, $zero, 0x12;
beq $t7, $t0, shift;
addi $t0, $zero, 0x59;
beq $t7, $t0, shift;
addi $t0, $zero, 0x1C;
beq $t7, $t0, letterA;
addi $t0, $zero, 0x32;
beq $t7, $t0, letterB;
addi $t0, $zero, 0x21;
beq $t7, $t0, letterC;
addi $t0, $zero, 0x23;
beq $t7, $t0, letterD;
addi $t0, $zero, 0x24;
beq $t7, $t0, letterE;
addi $t0, $zero, 0x2B;
beq $t7, $t0, letterF;
addi $t0, $zero, 0x34;
beq $t7, $t0, letterG;
addi $t0, $zero, 0x33;
beq $t7, $t0, letterH;
addi $t0, $zero, 0x43;
beq $t7, $t0, letterI;
addi $t0, $zero, 0x3B;
beq $t7, $t0, letterJ;
addi $t0, $zero, 0x42;
beq $t7, $t0, letterK;
addi $t0, $zero, 0x4B;
beq $t7, $t0, letterL;
addi $t0, $zero, 0x3A;
beq $t7, $t0, letterM;
addi $t0, $zero, 0x31;
beq $t7, $t0, letterN;
addi $t0, $zero, 0x44;
beq $t7, $t0, letterO;
addi $t0, $zero, 0x4D;
beq $t7, $t0, letterP;
addi $t0, $zero, 0x15;
beq $t7, $t0, letterQ;
addi $t0, $zero, 0x2D;
beq $t7, $t0, letterR;
addi $t0, $zero, 0x1B;
beq $t7, $t0, letterS;
addi $t0, $zero, 0x2C;
beq $t7, $t0, letterT;
addi $t0, $zero, 0x3C;
beq $t7, $t0, letterU;
addi $t0, $zero, 0x2A;
beq $t7, $t0, letterV;
addi $t0, $zero, 0x1D;
beq $t7, $t0, letterW;
addi $t0, $zero, 0x22;
beq $t7, $t0, letterX;
addi $t0, $zero, 0x35;
beq $t7, $t0, letterY;
addi $t0, $zero, 0x1A;
beq $t7, $t0, letterZ;
addi $t0, $zero, 0x76;
beq $t7, $t0, Start;

addi $t0, $zero, 0x45;
beq $t7, $t0, number0;
addi $t0, $zero, 0x16;
beq $t7, $t0, number1;
addi $t0, $zero, 0x1E;
beq $t7, $t0, number2;
addi $t0, $zero, 0x26;
beq $t7, $t0, number3;
addi $t0, $zero, 0x25;
beq $t7, $t0, number4;
addi $t0, $zero, 0x2E;
beq $t7, $t0, number5;
addi $t0, $zero, 0x36;
beq $t7, $t0, number6;
addi $t0, $zero, 0x3D;
beq $t7, $t0, number7;
addi $t0, $zero, 0x3E;
beq $t7, $t0, number8;
addi $t0, $zero, 0x46;
beq $t7, $t0, number9;

addi $t0, $zero, 0x0E;
beq $t7, $t0, ascii96;
addi $t0, $zero, 0x4E;
beq $t7, $t0, minus;
addi $t0, $zero, 0x55;
beq $t7, $t0, equal;
addi $t0, $zero, 0x5D;
beq $t7, $t0, fanxiegang;
addi $t0, $zero, 0x4C;
beq $t7, $t0, fenhao;
addi $t0, $zero, 0x52;
beq $t7, $t0, danyinhao;
addi $t0, $zero, 0x41;
beq $t7, $t0, douhao;
addi $t0, $zero, 0x49;
beq $t7, $t0, juhao;
addi $t0, $zero, 0x4A;
beq $t7, $t0, divide;
addi $t0, $zero, 0x54;
beq $t7, $t0, zhongkuohao1;
addi $t0, $zero, 0x5B;
beq $t7, $t0, zhongkuohao2;

addi $t0, $zero, 0x29;
beq $t7, $t0, space;
addi $t0, $zero, 0x5A;
beq $t7, $t0, enter;
addi $t0, $zero, 0x66;
beq $t7, $t0, popstack;

letterA:
addi $s0, $zero, 65;
j pushstack;
letterB:
addi $s0, $zero, 66;
j pushstack;
letterC:
addi $s0, $zero, 67;
j pushstack;
letterD:
addi $s0, $zero, 68;
j pushstack;
letterE:
addi $s0, $zero, 69;
j pushstack;
letterF:
addi $s0, $zero, 70;
j pushstack;
letterG:
addi $s0, $zero, 71;
j pushstack;
letterH:
addi $s0, $zero, 72;
j pushstack;
letterI:
addi $s0, $zero, 73;
j pushstack;
letterJ:
addi $s0, $zero, 74;
j pushstack;
letterK:
addi $s0, $zero, 75;
j pushstack;
letterL:
addi $s0, $zero, 76;
j pushstack;
letterM:
addi $s0, $zero, 77;
j pushstack;
letterN:
addi $s0, $zero, 78;
j pushstack;
letterO:
addi $s0, $zero, 79;
j pushstack;
letterP:
addi $s0, $zero, 80;
j pushstack;
letterQ:
addi $s0, $zero, 81;
j pushstack;
letterR:
addi $s0, $zero, 82;
j pushstack;
letterS:
addi $s0, $zero, 83;
j pushstack;
letterT:
addi $s0, $zero, 84;
j pushstack;
letterU:
addi $s0, $zero, 85;
j pushstack;
letterV:
addi $s0, $zero, 86;
j pushstack;
letterW:
addi $s0, $zero, 87;
j pushstack;
letterX:
addi $s0, $zero, 88;
j pushstack;
letterY:
addi $s0, $zero, 89;
j pushstack;
letterZ:
addi $s0, $zero, 90;
j pushstack;
space:
addi $s0, $zero, 32;
j pushstack;

number0:
addi $s0, $zero, 48;
j pushstack;
number1:
addi $s0, $zero, 49;
j pushstack;
number2:
addi $s0, $zero, 50;
j pushstack;
number3:
addi $s0, $zero, 51;
j pushstack;
number4:
addi $s0, $zero, 52;
j pushstack;
number5:
addi $s0, $zero, 53;
j pushstack;
number6:
addi $s0, $zero, 54;
j pushstack;
number7:
addi $s0, $zero, 55;
j pushstack;
number8:
addi $s0, $zero, 56;
j pushstack;
number9:
addi $s0, $zero, 57;
j pushstack;

ascii96:
addi $s0, $zero, 96;
j pushstack;
minus:
addi $s0, $zero, 45;
j pushstack;
equal:
addi $s0, $zero, 61;
j pushstack;
fanxiegang:
addi $s0, $zero, 92;
j pushstack;
fenhao:
addi $s0, $zero, 59;
j pushstack;
danyinhao:
addi $s0, $zero, 39;
j pushstack;
douhao:
addi $s0, $zero, 44;
j pushstack;
juhao:
addi $s0, $zero, 46;
j pushstack;
divide:
addi $s0, $zero, 47;
j pushstack;
zhongkuohao1:
addi $s0, $zero, 91;
j pushstack;
zhongkuohao2:
addi $s0, $zero, 93;
j pushstack;

second:
addi $a1, $zero, 0;
addi $t0, $zero, 0x12;
beq $t7, $t0, shift;
addi $t0, $zero, 0x59;
beq $t7, $t0, shift;
addi $t0, $zero, 0x1C;
beq $t7, $t0, smallletterA;
addi $t0, $zero, 0x32;
beq $t7, $t0, smallletterB;
addi $t0, $zero, 0x21;
beq $t7, $t0, smallletterC;
addi $t0, $zero, 0x23;
beq $t7, $t0, smallletterD;
addi $t0, $zero, 0x24;
beq $t7, $t0, smallletterE;
addi $t0, $zero, 0x2B;
beq $t7, $t0, smallletterF;
addi $t0, $zero, 0x34;
beq $t7, $t0, smallletterG;
addi $t0, $zero, 0x33;
beq $t7, $t0, smallletterH;
addi $t0, $zero, 0x43;
beq $t7, $t0, smallletterI;
addi $t0, $zero, 0x3B;
beq $t7, $t0, smallletterJ;
addi $t0, $zero, 0x42;
beq $t7, $t0, smallletterK;
addi $t0, $zero, 0x4B;
beq $t7, $t0, smallletterL;
addi $t0, $zero, 0x3A;
beq $t7, $t0, smallletterM;
addi $t0, $zero, 0x31;
beq $t7, $t0, smallletterN;
addi $t0, $zero, 0x44;
beq $t7, $t0, smallletterO;
addi $t0, $zero, 0x4D;
beq $t7, $t0, smallletterP;
addi $t0, $zero, 0x15;
beq $t7, $t0, smallletterQ;
addi $t0, $zero, 0x2D;
beq $t7, $t0, smallletterR;
addi $t0, $zero, 0x1B;
beq $t7, $t0, smallletterS;
addi $t0, $zero, 0x2C;
beq $t7, $t0, smallletterT;
addi $t0, $zero, 0x3C;
beq $t7, $t0, smallletterU;
addi $t0, $zero, 0x2A;
beq $t7, $t0, smallletterV;
addi $t0, $zero, 0x1D;
beq $t7, $t0, smallletterW;
addi $t0, $zero, 0x22;
beq $t7, $t0, smallletterX;
addi $t0, $zero, 0x35;
beq $t7, $t0, smallletterY;
addi $t0, $zero, 0x1A;
beq $t7, $t0, smallletterZ;
addi $t0, $zero, 0x76;
beq $t7, $t0, Start;

addi $t0, $zero, 0x45;
beq $t7, $t0, shift_number0;
addi $t0, $zero, 0x16;
beq $t7, $t0, shift_number1;
addi $t0, $zero, 0x1E;
beq $t7, $t0, shift_number2;
addi $t0, $zero, 0x26;
beq $t7, $t0, shift_number3;
addi $t0, $zero, 0x25;
beq $t7, $t0, shift_number4;
addi $t0, $zero, 0x2E;
beq $t7, $t0, shift_number5;
addi $t0, $zero, 0x36;
beq $t7, $t0, shift_number6;
addi $t0, $zero, 0x3D;
beq $t7, $t0, shift_number7;
addi $t0, $zero, 0x3E;
beq $t7, $t0, shift_number8;
addi $t0, $zero, 0x46;
beq $t7, $t0, shift_number9;

addi $t0, $zero, 0x0E;
beq $t7, $t0, shift_ascii96;
addi $t0, $zero, 0x4E;
beq $t7, $t0, shift_minus;
addi $t0, $zero, 0x55;
beq $t7, $t0, shift_equal;
addi $t0, $zero, 0x5D;
beq $t7, $t0, shift_fanxiegang;
addi $t0, $zero, 0x4C;
beq $t7, $t0, shift_fenhao;
addi $t0, $zero, 0x52;
beq $t7, $t0, shift_danyinhao;
addi $t0, $zero, 0x41;
beq $t7, $t0, shift_douhao;
addi $t0, $zero, 0x49;
beq $t7, $t0, shift_juhao;
addi $t0, $zero, 0x4A;
beq $t7, $t0, shift_divide;
addi $t0, $zero, 0x54;
beq $t7, $t0, shift_zhongkuohao1;
addi $t0, $zero, 0x5B;
beq $t7, $t0, shift_zhongkuohao2;

addi $t0, $zero, 0x29;
beq $t7, $t0, space;
addi $t0, $zero, 0x5A;
beq $t7, $t0, enter;
addi $t0, $zero, 0x66;
beq $t7, $t0, popstack;

smallletterA:
addi $s0, $zero, 97;
j pushstack;
smallletterB:
addi $s0, $zero, 98;
j pushstack;
smallletterC:
addi $s0, $zero, 99;
j pushstack;
smallletterD:
addi $s0, $zero, 100;
j pushstack;
smallletterE:
addi $s0, $zero, 101;
j pushstack;
smallletterF:
addi $s0, $zero, 102;
j pushstack;
smallletterG:
addi $s0, $zero, 103;
j pushstack;
smallletterH:
addi $s0, $zero, 104;
j pushstack;
smallletterI:
addi $s0, $zero, 105;
j pushstack;
smallletterJ:
addi $s0, $zero, 106;
j pushstack;
smallletterK:
addi $s0, $zero, 107;
j pushstack;
smallletterL:
addi $s0, $zero, 108;
j pushstack;
smallletterM:
addi $s0, $zero, 109;
j pushstack;
smallletterN:
addi $s0, $zero, 110;
j pushstack;
smallletterO:
addi $s0, $zero, 111;
j pushstack;
smallletterP:
addi $s0, $zero, 112;
j pushstack;
smallletterQ:
addi $s0, $zero, 113;
j pushstack;
smallletterR:
addi $s0, $zero, 114;
j pushstack;
smallletterS:
addi $s0, $zero, 115;
j pushstack;
smallletterT:
addi $s0, $zero, 116;
j pushstack;
smallletterU:
addi $s0, $zero, 117;
j pushstack;
smallletterV:
addi $s0, $zero, 118;
j pushstack;
smallletterW:
addi $s0, $zero, 119;
j pushstack;
smallletterX:
addi $s0, $zero, 120;
j pushstack;
smallletterY:
addi $s0, $zero, 121;
j pushstack;
smallletterZ:
addi $s0, $zero, 122;
j pushstack;

shift_number0:
addi $s0, $zero, 41;
j pushstack;
shift_number1:
addi $s0, $zero, 33;
j pushstack;
shift_number2:
addi $s0, $zero, 64;
j pushstack;
shift_number3:
addi $s0, $zero, 35;
j pushstack;
shift_number4:
addi $s0, $zero, 36;
j pushstack;
shift_number5:
addi $s0, $zero, 37;
j pushstack;
shift_number6:
addi $s0, $zero, 94;
j pushstack;
shift_number7:
addi $s0, $zero, 38;
j pushstack;
shift_number8:
addi $s0, $zero, 42;
j pushstack;
shift_number9:
addi $s0, $zero, 40;
j pushstack;

shift_ascii96:
addi $s0, $zero, 126;
j pushstack;
shift_minus:
addi $s0, $zero, 95;
j pushstack;
shift_equal:
addi $s0, $zero, 43;
j pushstack;
shift_fanxiegang:
addi $s0, $zero, 124;
j pushstack;
shift_fenhao:
addi $s0, $zero, 58;
j pushstack;
shift_danyinhao:
addi $s0, $zero, 34;
j pushstack;
shift_douhao:
addi $s0, $zero, 60;
j pushstack;
shift_juhao:
addi $s0, $zero, 62;
j pushstack;
shift_divide:
addi $s0, $zero, 63;
j pushstack;
shift_zhongkuohao1:
addi $s0, $zero, 123;
j pushstack;
shift_zhongkuohao2:
addi $s0, $zero, 125;
j pushstack;

pushstack:	// push chars
addi $s6, $s6, 1;
addi $s3, $s3, 1; // stack
addi $s4, $s4, 1;
bne $s4, $a0, next;
and $s4, $s4, $zero;
addi $s5, $s5, 1;
next:
lui $s1, 0x000C;  // write the char ram
add $s1, $s1, $s6;
addi $s1, $s1, -1;
sw $s0, 0($s1);

//addi $s1, $zero, 900  // stack
lui $s1, 0x000E;

add $s1, $s1, $s3;
add $s1, $s1, $s3;
add $s1, $s1, $s3;
add $s1, $s1, $s3; //pointer*4

addi $s1, $s1, -4;
sw $s0, 0($s1);

j draw;

enter:	// change line

lui $t0, 0x000C;
add $t0, $t0, $s6;
addi $t1, $zero, 20;
sw $t1, 0($t0);

addi $s5, $s5, 1;
and $s4, $s4, $zero;
addi $s4, $s4, 1;
and $s6, $s6, $zero;
add $t2, $zero, $s5;

loop:
add $s6, $s6, $a0;
addi $t2, $t2, -1;
bne $t2, $zero, loop;

j compare1;

//j draw

popstack:	// backspace
beq $s6, $zero, next2;
addi $s6, $s6, -1;
addi $s4, $s4, -1;
beq $s3, $zero, next2;
addi $s3, $s3, -1;
next2:

j draw;

draw:
and $s1, $zero, $zero;
and $s2, $zero, $zero;
lui $s1, 0x000C;
addi $s1, $s1, 0x12bf;
lui $s2, 0x000C;
add $s2, $s2, $s6;
addi $t3, $zero, 95;
sw $t3, 0($s2);
addi $s2, $s2, 1;
addi $t3, $zero, 0x20;
loop2:
sw $t3, 0($s2);
addi $s2, $s2, 1;
bne $s1, $s2, loop2;

j Start;

shift:
addi $a1, $a1, 1;
j Start;

compare1: // command1: test

addi $t1, $zero, 4;
bne $t1, $s3, compare2;
lui $s1, 0x000E;
lw $t0, 0($s1);
addi $t1, $zero, 84;
bne $t0, $t1, compare2;
lw $t0, 4($s1);
addi $t1, $zero, 69;
bne $t0, $t1, compare2;
lw $t0, 8($s1);
addi $t1, $zero, 83;
bne $t0, $t1, compare2;
lw $t0, 12($s1);
addi $t1, $zero, 84;
bne $t0, $t1, compare2;
and $s3, $s3, $zero;
j Test;

compare2: // command1: game
addi $t1, $zero, 4;
bne $t1, $s3, No;
lui $s1, 0x000E;
lw $t0, 0($s1);
addi $t1, $zero, 71;
bne $t0, $t1, No;
lw $t0, 4($s1);
addi $t1, $zero, 65;
bne $t0, $t1, No;
lw $t0, 8($s1);
addi $t1, $zero, 77;
bne $t0, $t1, No;
lw $t0, 12($s1);
addi $t1, $zero, 69;
bne $t0, $t1, No;
and $s3, $s3, $zero;
j Game_Initial;

No:
and $s3, $s3, $zero;
lui $t0, 0x000C;
add $t0, $t0, $s6;
addi $t1, $zero, 69;
sw $t1, 0($t0);
addi $t1, $zero, 82;
sw $t1, 1($t0);
addi $t1, $zero, 82;
sw $t1, 2($t0);
addi $t1, $zero, 79;
sw $t1, 3($t0);
addi $t1, $zero, 82;
sw $t1, 4($t0);
addi $t1, $zero, 33;
sw $t1, 5($t0);

addi $s5, $s5, 1;     // next line
and $s4, $s4, $zero;
addi $s4, $s4, 1;
and $s6, $s6, $zero;
add $t2, $zero, $s5;

loop_:
add $s6, $s6, $a0;
addi $t2, $t2, -1;
bne $t2, $zero, loop_;

j draw;

Test: //HelloWorld!

lui $s1, 0x000C;
addi $s2, $zero, 72;
sw $s2, 0($s1);
addi $s2, $zero, 101;
sw $s2, 1($s1);
addi $s2, $zero, 108;
sw $s2, 2($s1);
addi $s2, $zero, 108;
sw $s2, 3($s1);
addi $s2, $zero, 111;
sw $s2, 4($s1);
addi $s2, $zero, 87;
sw $s2, 5($s1);
addi $s2, $zero, 111;
sw $s2, 6($s1);
addi $s2, $zero, 114;
sw $s2, 7($s1);
addi $s2, $zero, 108;
sw $s2, 8($s1);
addi $s2, $zero, 100;
sw $s2, 9($s1);
addi $s2, $zero, 33;
sw $s2, 10($s1);

and $s1, $zero, $zero;
and $s2, $zero, $zero;
lui $s1, 0x000C;
addi $s1, $s1, 0x12bf;
lui $s2, 0x000C;
addi $s2, $s2, 11;
addi $t3, $zero, 0x20;
loop_test:
sw $t3, 0($s2);
addi $s2, $s2, 1;
bne $s1, $s2, loop_test;

lw $t7, 0($s7);
beq $t7, $zero, Test;
addi $t6, $zero, 0x76;
bne $t6, $t7, Test;

and $s1, $zero, $zero; // clear screen
and $s2, $zero, $zero;
lui $s1, 0x000C;
addi $s1, $s1, 0x12bf;
lui $s2, 0x000C;
addi $t3, $zero, 0x20;
clear:
sw $t3, 0($s2);
addi $s2, $s2, 1;
bne $s1, $s2, clear;

j Initial;

Game_Initial:
lui $s7, 0x000D;
lui $s6, 0x000F;
addi $s0, $zero, 40; // character_x
addi $s1, $zero, 0;  // barrier_y
addi $s2, $zero, 79; // max_x
addi $s3, $zero, 59; // max_y
addi $s4, $zero, 0; // score
lui $t1, 0xE000;
sw $s4, 0($t1);
addi $t5, $zero, 30;

Game_Start:

lui $t1, 0x000C;       // clear screen
addi $t1, $t1, 0x12bf;
lui $t2, 0x000C;
addi $t3, $zero, 0x20; // space
Game_Loop:
sw $t3, 0($t2);
addi $t2, $t2, 1;
slt $t4, $t1, $t2;
beq $t4, $zero, Game_Loop;

addi $t4, $zero, 0;
addi $t3, $zero, 500;
Game_Delay1:
addi $t4, $t4, 1;
bne $t4, $t3, Game_Delay1;

lw $s5, 0($s7); //PS2
and $t6, $zero, $zero;
and $t7, $zero, $zero;
addi $t0, $zero, 0x1C;
beq $s5, $t0, left_signal;
Back:
addi $t0, $zero, 0x23;
beq $s5, $t0, right_signal;
j Game_signal_next;

left_signal:
addi $t6, $zero, 1;
j Back;

right_signal:
addi $t7, $zero, 1;

Game_signal_next:

addi $t0, $zero, 0x76;
beq $s5, $t0, Initial;

slt $t0, $s1, $s3;
bne $t0, $zero, Game_Left;
addi $s1, $zero, 0;

beq $t6, $zero, random1;
addi $t5, $t5, 13;
random1:
beq $t7, $zero, random2;
ori $t5, $t5, 29;
random2:
addi $t5, $t5, 17;
andi $t5, $t5, 0x3f;

Game_Left:
addi $t4, $zero, 1;
bne $t6, $t4, Game_Right;
addi $s0, $s0, -1;
slt $t4, $s0, $zero;
beq $t4, $zero, Game_game;
addi $s0, $zero, 79;
j Game_game;

Game_Right:
addi $t4, $zero, 1;
bne $t7, $t4, Game_game;
addi $s0, $s0, 1;
slt $t4, $s0, $s2;
bne $t4, $zero, Game_game;
and $s0, $zero, $zero;

Game_game:
lui $t0, 0x000C;
addi $t0, $t0, 3999;
add $t0, $t0, $s0;
addi $t1, $zero, 127;
sw $t1, 0($t0);
sw $t1, 1($t0);
addi $t0, $t0, 80;
sw $t1, 0($t0);
sw $t1, 1($t0); // draw cube

or $t2, $s1, $zero;
and $t0, $t0, $zero;
lui $t0, 0x000C;
addi $t1, $zero, 1;
Game_Loop2:
beq $t2, $zero, Game_Next1;
addi $t0, $t0, 80;
sub $t2, $t2, $t1;
j Game_Loop2;
and $t2, $t2, $zero;
Game_Next1:
addi $t1, $zero, 127;

slt $t3, $t2, $t5;
bne $t3, $zero, Game_draw;
addi $t4, $t5, 10;
slt $t3, $t4, $t2;
bne $t3, $zero, Game_draw;
j Game_No_draw;

Game_draw:
sw $t1, 0($t0);
sw $t1, 80($t0);
Game_No_draw:
addi $t0, $t0, 1;
addi $t2, $t2, 1;
addi $t4, $s2, 1;
beq $t2, $t4, Game_Next2;

j Game_Next1;

Game_Next2:
addi $t4, $zero, 51;
bne $s1, $t4, Game_Next3;
slt $t3, $s0, $t5;
bne $t3, $zero, Game_Initial;
addi $t4, $t5, 8;
slt $t3, $t4, $s0;
bne $t3, $zero, Game_Initial;
addi $s4, $s4, 1;
lui $t3, 0xE000;
sw $s4, 0($t3);
Game_Next3:
addi $s1, $s1, 1;

addi $t4, $zero, 0;
addi $t3, $zero, 30000;
Game_Delay2:
addi $t4, $t4, 1;
bne $t4, $t3, Game_Delay2;
j Game_Start;
