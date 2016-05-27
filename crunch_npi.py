from refined_luhn import is_luhn_valid


def validate_all_npi_values():
    row_count = 0
    with open('/npi/npidata.csv', 'r') as npi_file:
        for row in npi_file:
            if row_count > 0:
                fields = row.split(',')
                npi = '80840' + fields[0][1:-1]
                is_luhn_valid(npi)
            row_count += 1


if __name__ == "__main__":
    validate_all_npi_values()
