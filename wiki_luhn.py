# from https://en.wikipedia.org/wiki/Luhn_algorithm
def digits_of(number):
    return [int(digit) for digit in str(number)]


def luhn_checksum(card_number):
    digits = digits_of(card_number)
    odd_digits = digits[-1::-2]
    even_digits = digits[-2::-2]
    total = sum(odd_digits)
    for digit in even_digits:
        total += sum(digits_of(2 * digit))
    return total % 10


def is_luhn_valid(card_number):
    return luhn_checksum(card_number) == 0
