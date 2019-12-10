CC=gcc

all: calculator

calculator: main.c calculator.yy.c calculator.tab.c
	$(CC) -o $@ $^ -lm 

calculator.yy.c: calculator.lex
	flex -o $@ $^

calculator.tab.c: calculator.y
	bison -d -v -o $@ $^

clean:
	rm calculator.tab.c calculator.tab.h calculator