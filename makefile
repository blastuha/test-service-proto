# Переменные
PROTO_DIR = proto
GEN_DIR = gen
PROTOC = protoc

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

