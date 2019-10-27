#/bin/sh
COLOR_NONE="\033[0m"
COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[1;33m"
COLOR_GREEN="\033[1;32m"
COLOR_LIGHTCYAN="\033[1;36m"

echo "${COLOR_YELLOW}Part 1 of 3 -- set-up scripts correct permission${COLOR_NONE}"

echo -n "${COLOR_LIGHTCYAN}-- Setting up correct file permission on scripts... ${COLOR_NONE}"
(chmod +x ./build_dependencies.sh && chmod +x ./scripts/*.sh) 2> /dev/null
if [ "$?" -ne "0" ]; then
  echo "${COLOR_RED}failed${COLOR_NONE}"
  echo "${COLOR_RED}ERROR: failed setting permission on scripts! Not enough privileges?${COLOR_NONE}"
  exit 1
else
  echo "${COLOR_GREEN}done${COLOR_NONE}"
fi

echo ""
echo "${COLOR_YELLOW}Part 2 of 3 -- set-up git hooks${COLOR_NONE}"
echo -n "${COLOR_LIGHTCYAN}-- Attaching pre-commit hook to repository...${COLOR_NONE}"
if [ -f "./.git/hooks/pre-commit" ]; then
  rm "./.git/hooks/pre-commit" 2> /dev/null
  if [ "$?" -ne "0" ]; then
    echo "${COLOR_RED}failed${COLOR_NONE}"
    echo "${COLOR_RED}ERROR: failed removing previous set-up pre-commit hook${COLOR_NONE}"
    exit 1
  fi
fi
ln -s ../../scripts/pre-commit.sh ./.git/hooks/pre-commit 2> /dev/null
if [ "$?" -ne "0" ]; then
  echo "${COLOR_RED}failed${COLOR_NONE}"
  echo "${COLOR_RED}ERROR: failed setting pre-commit hook${COLOR_NONE}"
  exit 1
else
  echo "${COLOR_GREEN}done${COLOR_NONE}"
fi

echo ""
echo "${COLOR_YELLOW}Part 3 of 3 -- build dependencies${COLOR_NONE}"
while :
do
  echo -n "Build dependencies? (y/n) "
  read CHOICE
  case ${CHOICE} in
    Y | y)
      ./build_dependencies.sh
      break
      ;;
    N | n)
      exit 0
      ;;
  esac
done
