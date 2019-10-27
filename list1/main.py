import string_matching_algorithm as sma
import kmp_string_matching as kmp
import matching_test as mt


def main():
    # alphabet = "qwertyuiopasdfghjklzxcvbnm"

    tests = [
        mt.TestCase("αβγδ", "δ", "αβαβγβαβαβαβαβγ", 0),
        mt.TestCase("αβγδ", "γδ", "αβαβγβαβαβαβαβγ", 0),
        mt.TestCase("αβγδ", "αβ", "αβαβγβαβαβαβαβγ", 6),
        mt.TestCase("αβγδ", "αβαβ", "αβαβγβαβαβαβαβγ", 4),
        mt.TestCase(r"\| /", "|", r"\|\|\/\|/\ \\\ \\\ \/// //\|\|", 5),
        mt.TestCase(r"\| /", r"||", r"\|\|\/\|/\ \\\ \\\ \/// //\|\|", 0),
        mt.TestCase(r"\| /", r"\ \\", r"\|\|\/\|/\ \\\ \\\ \/// //\|\|", 2),
        mt.TestCase(r"\| /", r"//", r"\|\|\/\|/\ \\\ \\\ \/// //\|\|", 3),
        mt.TestCase(r"\| /", r"\|\\", r"\|\|\/\|/\ \\\ \\\ \/// //\|\|", 0),
        mt.TestCase(r"\| /", r"\|\|", r"\|\|\/\|/\ \\\ \\\ \/// //\|\|", 2),
    ]

    results = dict()
    passed = 0
    failed = 0
    equal_positive_results = 0
    for t in tests:
        r, equal_result = t.run_test()
        if r:
            passed += 1
        else:
            failed += 1
        if equal_result:
            equal_positive_results += 1
    print("---------RESULTS---------")
    print(
        f"PASSED: {passed}, FAILED: {failed}, TOTAL: {passed + failed}, NUMBER OF TESTS WHERE BOTH ALGORITHMS EQUALS: {equal_positive_results}")


if __name__ == '__main__':
    main()
