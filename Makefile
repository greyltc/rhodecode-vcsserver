
.PHONY: clean test test-clean test-only


clean:
	make test-clean
	find . -type f \( -iname '*.c' -o -iname '*.pyc' -o -iname '*.so' \) -exec rm '{}' ';'

test:
	make test-clean
	make test-only

test-clean:
	rm -rf coverage.xml htmlcov junit.xml pylint.log result
	find . -type d -name "__pycache__" -prune -exec rm -rf '{}' ';'

test-only:
	PYTHONHASHSEED=random py.test -vv -r xw -p no:sugar --cov=vcsserver --cov-report=term-missing --cov-report=html vcsserver
