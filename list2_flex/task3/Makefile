CC=gcc

all: task3

task3: task3.yy.c
	$(CC) -o $@ $^ -lfl

task3.yy.c: task3.lex
	flex -o $@ $^
