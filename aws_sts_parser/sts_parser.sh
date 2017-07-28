#!/bin/bash

name=$1
token=$2

if [  $token != " " ]; then
  echo $token

  getSession="$(aws sts get-session-token --serial-number arn:aws:iam::111222333444:mfa/$name --token-code $token)"

  #echo $getSession

  secretkey="$(echo $getSession | awk -F'[ ]' '{print $5}'| sed -e 's/^"//' -e 's/,//' -e 's/"$//' )"
  session="$(echo $getSession | awk -F'[ ]' '{print $7}'| sed -e 's/^"//' -e 's/,//' -e 's/"$//' )"
  accesskey="$(echo $getSession | awk -F'[ ]' '{print $11}'| sed -e 's/^"//' -e 's/,//' -e 's/"$//' )"

  #echo $secretkey
  #echo $session
  #echo $accesskey

  export AWS_SECRET_ACCESS_KEY=$secretkey
  export AWS_SESSION_TOKEN=$session
  export AWS_ACCESS_KEY_ID=$accesskey

else
  echo "argument error"
fi
