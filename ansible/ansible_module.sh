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

# string
str=$(echo ${input} | jq -r '.str')

# integer
int=$(echo ${input} | jq '.int')

# array - generate bash array from json
mapfile -t arr < <(echo ${input} | jq -r ".arr[]")

# hash - will stay a JSON string further parseable by jq
map=$(echo ${input} | jq '.hash')


# -----------------------------------------------------------------------------
# module processing
# -----------------------------------------------------------------------------

(
  echo string:
  echo $str

  echo

  echo integer:
  echo $int

  echo

  echo array:
  echo "size: ${#arr[@]}"
  for ((i=0; i<${#arr[@]}; i++)); do
    echo "[$i] ${arr[$i]}"
  done

  echo

  echo hash:
  echo ${map} | jq -r '.foo'

) > /tmp/test


# -----------------------------------------------------------------------------
# module output
# -----------------------------------------------------------------------------

echo "${output}"
