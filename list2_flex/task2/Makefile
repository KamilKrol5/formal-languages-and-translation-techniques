CC=gcc

all: task2

task2: task2.yy.c
	$(CC) -o $@ $^ -lfl

task2.yy.c: task2.lex
	flex -o $@ $^
