CC=gcc

all: task2.o

task2.o: task2.yy.c
	$(CC) -o $@ $^ -lfl

task2.yy.c: task2.lex
	flex -o $@ $^
