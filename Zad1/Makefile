# Nazwa pliku wykonywalnego
OUTPUT = main

# Nazwa pliku źródłowego i obiektowego
ASM_SOURCE = main.asm
OBJ_FILE = main.o

# Flagi kompilatora NASM
NASM_FLAGS = -f elf

# Flagi dla linkera
LD_FLAGS = -m elf_i386

# Domyślna reguła (wywoływana przez `make`)
all: $(OUTPUT)

# Kompilacja pliku źródłowego do pliku obiektowego
$(OBJ_FILE): $(ASM_SOURCE)
	nasm $(NASM_FLAGS) $(ASM_SOURCE) -o $(OBJ_FILE)

# Linkowanie pliku obiektowego do programu wykonywalnego
$(OUTPUT): $(OBJ_FILE)
	ld $(LD_FLAGS) $(OBJ_FILE) -o $(OUTPUT)

run: $(OUTPUT)
	./$(OUTPUT)
# Usuwanie plików tymczasowych
clean:
	rm -f $(OBJ_FILE) $(OUTPUT)
