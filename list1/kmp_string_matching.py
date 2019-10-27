class KMPMatching:
    def __init__(self, pattern, alphabet):
        self.alphabet = alphabet
        self.pattern = pattern
        self.prefix_function = self.compute_prefix_function()

    def compute_prefix_function(self):
        pattern_length = len(self.pattern)
        pi = dict()
        pi[1] = 0
        k = 0
        for q in range(2, pattern_length + 1):
            while k > 0 and self.pattern[k] != self.pattern[q-1]:
                k = pi[k]
            if self.pattern[k] == self.pattern[q-1]:
                k = k + 1
            pi[q] = k
        return pi

    def kmp_matcher(self, text):
        number_of_occurrences = 0
        n = len(text)
        m = len(self.pattern)
        q = 0  # number of symbols that match
        for i in range(n):  # look up the text from left to right
            while q > 0 and self.pattern[q] != text[i]:
                q = self.prefix_function[q]  # the next symbol does not match
            if self.pattern[q] == text[i]:
                q = q + 1  # the next symbol matches
            if q == m:  # checks if whole pattern is matched
                number_of_occurrences += 1
                # print(f"KMP: Wzorzec {self.pattern} występuje z przesunięciem ", i - len(self.pattern) + 1)
                q = self.prefix_function[q]  #
        print(f"KMP: Number of occurrences of pattern {self.pattern}: {number_of_occurrences}")
        return number_of_occurrences
