import string_matching_algorithm as sma
import kmp_string_matching as kmp


class TestCase:
    def __init__(self, alphabet, pattern, text, expected_result):
        self.expected_result = expected_result
        self.pattern = pattern
        self.alphabet = alphabet
        self.text = text

    def run_test(self):
        kmp_automaton = kmp.KMPMatching(self.pattern, self.alphabet)
        automaton = sma.MatchingAutomaton(self.pattern, self.alphabet)

        kmp_count = kmp_automaton.kmp_matcher(self.text)
        second_count = automaton.find_string(self.text)

        print("----------")
        print(f"{self}KMP({kmp_count}) equals normal({second_count}): {kmp_count == second_count}")
        result = kmp_count == second_count == self.expected_result
        print(f"TEST RESULT: {result} \n")
        return result, kmp_count == second_count

    def __str__(self):
        return f"pattern: {self.pattern}, alphabet: {self.alphabet}, text: {self.text}, expected: {self.expected_result}\n"
