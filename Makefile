TESTFILES := $(wildcard tests/*)
test:
	@for test in ${TESTFILES}; do "$$test"; done
