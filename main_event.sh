echo "Setting up NPI data for test runs"
unzip NPPES_Data_Dissemination_May_2016.zip npidata_20050523-20160508.csv
mv npidata_20050523-20160508.csv npidata.csv

echo "Running with https://en.wikipedia.org/wiki/Luhn_algorithm Python code"
echo "python2.7 - wiki edition"
python2.7 -m timeit -s "from wiki_luhn import is_luhn_valid" "is_luhn_valid('808401467857193')"
echo "python3.5 - wiki edition"
python3.5 -m timeit -s "from wiki_luhn import is_luhn_valid" "is_luhn_valid('808401467857193')"
echo "pypy - wiki edition"
pypy -m timeit -s "from wiki_luhn import is_luhn_valid" "is_luhn_valid('808401467857193')"

echo "Running with refined Python code"
echo "python2.7 - refined edition"
python2.7 -m timeit -s "from refined_luhn import is_luhn_valid" "is_luhn_valid('808401467857193')"
echo "python3.5 - refined edition"
python3.5 -m timeit -s "from refined_luhn import is_luhn_valid" "is_luhn_valid('808401467857193')"
echo "pypy - refined edition"
pypy -m timeit -s "from refined_luhn import is_luhn_valid" "is_luhn_valid('808401467857193')"

export CLASSPATH=.:/npi/commons-validator-1.5.1.jar
javac CrunchNPI.java

echo "Validating All NPIs with Java"
time java CrunchNPI

echo "Validating All NPIs with Python and PyPy"
time pypy crunch_npi.py