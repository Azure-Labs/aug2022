#Shell script to load test endpoint 200 times with 10 paralall
echo "Loading endpoint: $1";
seq 1 50 | xargs -n1 -P10  curl $1 > /dev/null
echo "Finish Loading"