.PHONY: setup run check check-clean live archive test lint

setup:
	go run . setup

run:
	go run . run $(BENCH_ARGS)

check:
	go run . check $(BENCH_ARGS)

check-clean:
	go run . check -extract-mode clean $(BENCH_ARGS)

live:
	go run . live $(BENCH_ARGS)

# Reproducible corpus tarball for archive.json (publish it as a release asset, then record its sha256 there).
archive:
	mkdir -p .runs
	cd testdata && tar --sort=name --owner=0 --group=0 --numeric-owner --mtime='2026-09-19 00:00Z' -czf ../.runs/corpus-500.tar.gz $$(ls | sort)
	sha256sum .runs/corpus-500.tar.gz

test:
	go vet ./... && go test ./...

lint:
	golangci-lint run
