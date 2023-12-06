#!/usr/bin/bash
#WANT_JSON

# -----------------------------------------------------------------------------
# module initialization
# -----------------------------------------------------------------------------

# read module input from given file
input=$(cat $1)
echo "$input" > /tmp/test1

# initialize output
output='{}'
output=$(echo ${output} | jq '.changed=false | .failed=false')


# -----------------------------------------------------------------------------
# create bash variables from module input JSON
# -----------------------------------------------------------------------------

# example string from argument "str"
str=$(echo ${input} | jq -r '.str')

# example integer from argument "int"
int=$(echo ${input} | jq '.int')

# array - generate bash array from json array in argument "arr"
mapfile -t arr < <(echo ${input} | jq -r ".arr[]")

# hash - will stay a JSON string further parseable by jq
map=$(echo ${input} | jq '.hash')


# -----------------------------------------------------------------------------
# module processing
# -----------------------------------------------------------------------------

(
  # example handling string argument
  echo string:
  echo $str

  echo

  # example handling int argument
  echo integer:
  echo $int

  echo

  # example handling array argument
  echo array:
  echo "size: ${#arr[@]}"
  for ((i=0; i<${#arr[@]}; i++)); do
    echo "[$i] ${arr[$i]}"
  done

  echo

  # example handling hash/dict argument
  echo hash:
  echo ${map} | jq -r '.foo'

) > /tmp/test


# -----------------------------------------------------------------------------
# module output
# -----------------------------------------------------------------------------

echo "${output}"
