#!/bin/sh

service nginx status

if [ $? != 0 ]; then
	service nginx restart
else
	service nginx reload
fi

exit 0