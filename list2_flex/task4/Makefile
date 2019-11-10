CC=gcc

all: task4

task4: task4.yy.c
	$(CC) -o $@ $^ -lfl -lm

task4.yy.c: task4.lex
	flex -o $@ $^
