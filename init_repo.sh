#/bin/sh
chmod +x ./build_dependencies.sh
chmod +x ./scripts/*.sh
ln -s ../../scripts/pre-commit.sh ./.git/hooks/pre-commit
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
