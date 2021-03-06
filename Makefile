
.PHONY: clean test test-clean test-only generate-pkgs pip-packages

# set by: PATH_TO_OUTDATED_PACKAGES=/some/path/outdated_packages.py
OUTDATED_PACKAGES = ${PATH_TO_OUTDATED_PACKAGES}

clean:
	make test-clean
	find . -type f \( -iname '*.c' -o -iname '*.pyc' -o -iname '*.so' -o -iname '*.orig' \) -exec rm '{}' ';'

test:
	make test-clean
	make test-only

test-clean:
	rm -rf coverage.xml htmlcov junit.xml pylint.log result
	find . -type d -name "__pycache__" -prune -exec rm -rf '{}' ';'

test-only:
	PYTHONHASHSEED=random \
	py.test -x -vv -r xw -p no:sugar \
	--cov=vcsserver --cov-report=term-missing --cov-report=html vcsserver

generate-pkgs:
	nix-shell pkgs/shell-generate.nix --command "pip2nix generate --licenses"

pip-packages:
	python ${OUTDATED_PACKAGES}
