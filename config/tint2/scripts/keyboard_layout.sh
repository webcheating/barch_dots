!/bin/bash

code=$(xset -q | grep LED | awk '{ print $10 }')

case "${code:4:1}" in
  '0')
    layout='[us]'
    ;;
  '1')
    layout='[ru]'
    ;;
  *)
    layout='unknown'
    ;;
esac

if [ "$layout" = 'unknown' ]; then
  echo "error"
else
  echo "$layout"
fi

