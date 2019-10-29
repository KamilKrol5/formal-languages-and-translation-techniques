import string_matching_algorithm as sma
import kmp_string_matching as kmp
import matching_test as mt


def main():
    # alphabet = "qwertyuiopasdfghjklzxcvbnm"

    tests = [
        # mt.TestCase("αβγδ", "δ", "αβαβγβαβαβαβαβγ", 0),
        # mt.TestCase("αβγδ", "γδ", "αβαβγβαβαβαβαβγ", 0),
        # mt.TestCase("αβγδ", "αβ", "αβαβγβαβαβαβαβγ", 6),
        # mt.TestCase("αβγδ", "αβαβ", "αβαβγβαβαβαβαβγ", 4),
        # mt.TestCase(r"\| /", "|", r"\|\|\/\|/\ \\\ \\\ \/// //\|\|", 5),
        # mt.TestCase(r"\| /", r"||", r"\|\|\/\|/\ \\\ \\\ \/// //\|\|", 0),
        # mt.TestCase(r"\| /", r"\ \\", r"\|\|\/\|/\ \\\ \\\ \/// //\|\|", 2),
        # mt.TestCase(r"\| /", r"//", r"\|\|\/\|/\ \\\ \\\ \/// //\|\|", 3),
        # mt.TestCase(r"\| /", r"\|\\", r"\|\|\/\|/\ \\\ \\\ \/// //\|\|", 0),
        # mt.TestCase(r"\| /", r"\|\|", r"\|\|\/\|/\ \\\ \\\ \/// //\|\|", 2),
        # mt.TestCase("7890", "0", "78787999997878787879", 0),
        # mt.TestCase("7890", "9", "78787999997878787879", 6),
        # mt.TestCase("7890", "789", "78787999997878787879", 0),
        # mt.TestCase("7890", "99", "78787999997878787879", 4),
        # mt.TestCase("7890", "879", "78787999997878787879", 2),
        # mt.TestCase("7890", "978", "78787999997878787879", 1),
        # mt.TestCase("XYZW", "W", "XYXYYXYYYXYYYYXYXYXYXZYXZ", 0),
        # mt.TestCase("XYZW", "YW", "XYXYYXYYYXYYYYXYXYXYXZYXZ", 0),
        # mt.TestCase("XYZW", "YX", "XYXYYXYYYXYYYYXYXYXYXZYXZ", 8),
        # mt.TestCase("XYZW", "YY", "XYXYYXYYYXYYYYXYXYXYXZYXZ", 6),
        # mt.TestCase("XYZW", "XYX", "XYXYYXYYYXYYYYXYXYXYXZYXZ", 4),
        # mt.TestCase("XYZW", "XYXY", "XYXYYXYYYXYYYYXYXYXYXZYXZ", 3),
        mt.TestCase("maμαま", "a", "μμμαまmαmmmαααμmμμμまmμmまμままααmαμμまままαまmαμまααmααmμμαμままmまmmμαまmμαα", 0),
        mt.TestCase("maμαま", "ma", "μμμαまmαmmmαααμmμμμまmμmまμままααmαμμまままαまmαμまααmααmμμαμままmまmmμαまmμαα", 0),
        mt.TestCase("maμαま", "まm", "μμμαまmαmmmαααμmμμμまmμmまμままααmαμμまままαまmαμまααmααmμμαμままmまmmμαまmμαα", 0),
        mt.TestCase("maμαま", "αα", "μμμαまmαmmmαααμmμμμまmμmまμままααmαμμまままαまmαμまααmααmμμαμままmまmmμαまmμαα", 0),
        mt.TestCase("maμαま", "mαm", "μμμαまmαmmmαααμmμμμまmμmまμままααmαμμまままαまmαμまααmααmμμαμままmまmmμαまmμαα", 0),
        mt.TestCase("maμαま", "μ", "μμμαまmαmmmαααμmμμμまmμmまμままααmαμμまままαまmαμまααmααmμμαμままmまmmμαまmμαα", 0)
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
