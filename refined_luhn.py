#
# luhn checksum algorithm in Python courtesy of https://github.com/JaredCorduan aka JC
#
even_luhn_conversion = [0, 2, 4, 6, 8, 1, 3, 5, 7, 9]


def luhn_odd(number):
    """
    Recursive partner of luhn_even, adds the right-most digit to the tally and
    then calls luhn_even on the remaining digits

    :param number: the digits left to be added to the luhn checksum
    :return: the sum of the right-most digit and the results of luhn_even on
             the remaining digits
    """
    return 0 if number == 0 else luhn_even(number // 10) + number % 10


def luhn_even(number):
    """
    Recursive partner of luhn_odd, adds the sum of twice the right-most digit
    to the tally and then calls luhn_odd on the remaining digits

    :param number: the digits left to be added to the luhn checksum
    :return: the sum of the twice the right-most digit and the results of
             luhn_even on the remaining digits
    """
    return 0 if number == 0 else luhn_odd(number // 10) + even_luhn_conversion[number % 10]


def luhn(number):
    """
        Compute luhn checksum

        :param number: the value that is to be verified using the luhn algorithm
        :return: the luhn checksum based on the specified number
    """
    return luhn_odd(int(number)) % 10


def is_luhn_valid(number):
    """
        validation of number according to the luhn algorithm

        :param number: a string representing a number to be checked
        :return: True if the supplied number is valid based on the computed luhn checksum
    """
    return luhn(number) == 0
