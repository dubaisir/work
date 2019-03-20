#!/bin/bash

function echow()
{
  string=$@
  echo -e "--------\033[1;5;40;31m $string \033[0m--------"
}
function echoo()
{
 string=$@
  echo -e "--------\033[1;40;32m $string \033[0m--------"
}
