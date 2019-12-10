import sys

import ply.yacc as yacc
from calculator_lexer import tokens
from math import pow

precedence = (
    ('left', 'PLUS', 'MINUS'),
    ('left', 'TIMES', 'DIVIDE', 'MODULO'),
    ('right', 'UNARYMINUS'),
    ('right', 'POWER'),
)

start = 'input'


def p_input_notempty(p):
    'input : input line'
    # print('--- input: input line')
    pass


def p_input_emptyy(p):
    'input : empty'
    # print('--- input: empty')
    pass


def p_line(p):
    """line : ENDL
        | expression ENDL
        | error ENDL"""
    # print("--- line(1) : ...")
    if p[1] == '\n':
        pass
        # print("--- line(2) : ENDL")
    elif p[2] == '\n':
        # print("--- line(2) : expression ENDL OR error ENDL")
        # print("prr", p[1])
        print(p[1]['rpn'], '\n', p[1]['value'], '\n')


def p_expression_number(p):
    'expression : NUMBER'
    # print("--- expression : NUMBER")
    p[0] = p[1]


def p_expression_else(p):
    """expression : expression PLUS expression
                | expression MINUS expression
                | expression TIMES expression
                | expression DIVIDE expression
                | expression MODULO expression
                | MINUS expression %prec UNARYMINUS
                | expression POWER expression"""
    # print("--- expression : ...")
    if type(p[2]) is not dict and p[2] in {'+', '-', '*', '/', '^', '%'}:
        # print("Operation:", p[2])
        p[0] = build_value_for_binary_function(p[1], p[3], p[2])
    elif p[1] == '-':
        p[0] = build_value_for_negation(p[2])


def p_expression_parenthesis(p):
    'expression : LPAREN expression RPAREN'
    p[0] = p[2]


# Error rule for syntax errors
def p_error(p):
    print("Syntax error in input!", p)


def p_empty(p):
    'empty :'
    # print('--- empty: ')
    pass


def perform_operation(x, y, operator):
    operations = {
        "+": lambda a, b: a + b,
        "-": lambda a, b: a - b,
        "*": lambda a, b: a * b,
        "/": lambda a, b: a // b,
        "^": lambda a, b: pow(a, b),
        "%": lambda a, b: a % b,
    }
    return operations.get(operator, -1)(x, y)


def build_value_for_binary_function(e1, e2, operator):
    result_value = {
        'value': perform_operation(e1['value'], e2['value'], operator),
        'rpn': e1['rpn'] + ' ' + e2['rpn'] + ' ' + operator,
        'isOnlyNumber': False,
    }
    return result_value


def build_value_for_negation(expr):
    if expr['isOnlyNumber']:
        rpn_string = "- " + expr['rpn']
    else:
        rpn_string = expr['rpn'] + " ~"
    result_value = {'value': - expr['value'],
                    'rpn': rpn_string,
                    'isOnlyNumber': False,
                    }
    return result_value


# Build the parser
sys.stderr = sys.stdout
parser = yacc.yacc(debug=True)

while True:
    try:
        s = input('calc > ') + '\n'
        # print(repr(s))
    except EOFError:
        break
    if not s: continue
    result = parser.parse(s, debug=False)
    print(result)
