#!/bin/bash

get_deps () {
	mkdir -p tensorflow
	pip install --target=tensorflow tensorflow protobuf
	touch tensorflow/google/__init__.py
}

clean () {
	rm -rf tensorflow/tensorflow/examples/
	rm -rf tensorflow/tensorflow/contrib/
	rm -rf tensorflow/external/
	rm -rf tensorflow/tensorflow/include/unsupported/
	find -name "*.so" | xargs strip
	find -name "*.so.*" | xargs strip
	find . -name \*.pyc -delete
	find . -type d -name "tests" -exec rm -rf {} +
	rm tensorflow/easy_install.py
	rm -rf tensorflow/tensorboard/
	rm -rf tensorflow/wheel/
	rm -rf tensorflow/werkzeug/
	rm -rf tensorflow/markdown/
}

main () {
	get_deps
	clean
}

main
