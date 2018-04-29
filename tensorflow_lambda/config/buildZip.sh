#!/bin/bash

main () {
	zip -r9 --exclude=*/.pyc poc.zip ..
}

main
