import re

import ply.lex as lex

# List of literals
# literals = ['+', '-', '*', '/', ')', '(', '%', '^']
# List of token names
tokens = (
    'NUMBER',
    'PLUS',
    'MINUS',
    'TIMES',
    'DIVIDE',
    'MODULO',
    'POWER',
    'RPAREN',
    'LPAREN',
    'ENDL',
    'ANYTHING',
)

states = (
    ('COMMENT', 'exclusive'),
)

t_ignore_blanks = r'\s+'

def t_INITIAL_COMMENT_escapedEndLine(_):
    r'\\\n'
    pass


def t_COMMENT_ENDL(t):
    r'\n'
    t.lexer.begin('INITIAL')


def t_INITIAL_ENDL(t):
    r'\n'
    return t


def t_NUMBER(t):
    r'[0-9]+'
    # print("Number:", t.value)
    text = t.value
    t.value = dict()
    t.value['value'] = int(text)
    t.value['rpn'] = str(text)
    t.value['isOnlyNumber'] = True
    return t


# def t_ENDLINE(t):
# #     r'\$'
# #     print("ENDL")

# t_ENDLINE = r'\n'
t_ANYTHING = r'.'
t_RPAREN = r'\)'
t_LPAREN = r'\('
t_MODULO = r'\%'
t_POWER = r'\^'
t_DIVIDE = r'\/'
t_TIMES = r'\*'
t_MINUS = r'\-'
t_PLUS = r'\+'


def t_hashbeginningComment(t):
    r'^\#'
    t.lexer.begin('COMMENT')


def t_COMMENT_anythingInsideComment(t):
    r'.'
    pass


def t_ANY_error(t):
    print(f"Illegal character {t.value[0]}")
    t.lexer.skip(1)


lexer = lex.lex()

