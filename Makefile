# 文件名称: Makefile
# 文件功能: Makefile入口
# 该版作者: DXY

# 中国需要代理访问，非中国用户可以注释这里
export GOPROXY=https://goproxy.cn

# 可执行程序
lib := std

all:
	make clean
	make generate
	make build
	make test

generate:
	go build -o bin/generate cmd/generate.go
	for FileName in `find -name '*_generate_test.go'`; \
	do \
		echo "./bin/generate $$FileName"; \
		./bin/generate $$FileName; \
		go fmt; \
	done

build:
	for CmdName in $(lib); \
	do \
		echo "go build -buildmode=plugin -o ./bin/lib/$$CmdName.so ./lib/$$CmdName.go"; \
		go build -buildmode=plugin -o ./bin/lib/$$CmdName.so ./lib/$$CmdName.go; \
	done

test:
	go test
	for FileName in `find ./test -name '*.json'`; \
	do \
		echo "./bin/dl $$FileName"; \
		./bin/dl $$FileName; \
	done

clean:
	rm -rfdv ./bin/*

dist_clean: clean

.PHONY: \
	all \
	test \
	clean \
	dist_clean \
	generate \
	build
