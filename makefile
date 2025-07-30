# Переменные
PROTO_DIR = proto
GEN_DIR = gen
PROTOC = protoc

# Проверяем наличие protoc
.PHONY: check-protoc
check-protoc:
	@where protoc >nul 2>&1 || (echo "protoc не найден. Установите Protocol Buffers compiler" && exit 1)
	@where protoc-gen-go >nul 2>&1 || (echo "protoc-gen-go не найден. Установите: go install google.golang.org/protobuf/cmd/protoc-gen-go@latest" && exit 1)
	@where protoc-gen-go-grpc >nul 2>&1 || (echo "protoc-gen-go-grpc не найден. Установите: go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest" && exit 1)

# Генерация кода
.PHONY: generate
generate: check-protoc clean
	@if not exist $(GEN_DIR) mkdir $(GEN_DIR)
	@if not exist $(GEN_DIR)\user mkdir $(GEN_DIR)\user
	@if not exist $(GEN_DIR)\task mkdir $(GEN_DIR)\task
	
	$(PROTOC) --go_out=. --go-grpc_out=. $(PROTO_DIR)/user.proto
	
	$(PROTOC) --go_out=. --go-grpc_out=. $(PROTO_DIR)/task.proto
	

# Очистка сгенерированных файлов
.PHONY: clean
clean:
	@if exist $(GEN_DIR) rmdir /s /q $(GEN_DIR)

