class MatchingAutomaton:
    def __init__(self, pattern, alphabet):
        self.pattern = pattern
        self.alphabet = alphabet
        self.states = list(range(-1, len(pattern)))
        self.transition_function = dict()
        self.compute_transition_function()

    def find_string(self, text):
        if len(self.states) == 0:
            return True

        number_of_occurrences = 0
        n = len(text)
        accepted_state = self.states[-1]
        current_state = self.states[0]

        for i, letter in enumerate(text):  # 0 to n
            current_state = self.transition_function[current_state][letter]
            if current_state == accepted_state:
                number_of_occurrences += 1
                # print(f"Wzorzec {self.pattern} występuje z przesunięciem ", i - len(self.pattern)+1)

        print(f"Number of occurrences of pattern {self.pattern}: {number_of_occurrences}")
        return number_of_occurrences

    def compute_transition_function(self):
        # here we only need pattern and alphabet
        pattern_length = len(self.pattern)

        for q in range(self.states[0], self.states[pattern_length - 1]+2):
            self.transition_function[q] = dict()
            for letter in self.alphabet:
                k = min(pattern_length - 1, q + 1)
                # going down pattern (min (dlugość patternu, dlugosc patternu ktory teraz mam bo moze byc krotszy od
                # calego))
                # while self.pattern[:(k+1)] != self.pattern[q-k+1:(q+1)] + letter and k>=0:
                while not ((self.pattern[:(q+1)]+letter).endswith(self.pattern[:(k+1)])) and k >= 0:
                    k = k - 1
                self.transition_function[q][letter] = k
                # print(F"delta({q}, {letter}) = {k}")

    # returns the size of the longest prefix of pattern P which is suffix of argument
    # so when pattern is 'ab' s_f('a') = 1; s_f('ccaca') = 1; s_f(gfab) = 2
