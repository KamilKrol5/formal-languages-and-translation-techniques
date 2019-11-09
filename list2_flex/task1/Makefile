CC=gcc

all: task1.o

task1.o: task1.yy.c
	$(CC) -o $@ $^ -lfl

task1.yy.c: task1.lex
	flex -o $@ $^
