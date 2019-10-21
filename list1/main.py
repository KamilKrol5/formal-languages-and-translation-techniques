import string_matching_algorithm as sma


def main():
    # alphabet = "qwertyuiopasdfghjklzxcvbnm"

    # test1
    alphabet1 = "αβγδ"
    text1 = "αβαβγβαβαβαβαβγ"
    patterns1 = ["δ", "γδ", "αβ", "αβαβ"]

    automatons1 = [sma.MatchingAutomaton(pattern, alphabet1) for pattern in patterns1]
    for a in automatons1:
        a.find_string(text1)

    # test2
    alphabet2 = r"\| /"
    text2 = r"\|\|\/\|/\ \\\ \\\ \/// //\|\|"
    patterns2 = ["|", r"||", r"\ \\", r"//", r"\|\\", r"\|\|"]

    automatons2 = [sma.MatchingAutomaton(pattern, alphabet2) for pattern in patterns2]
    for a in automatons2:
        a.find_string(text2)


if __name__ == '__main__':
    main()
