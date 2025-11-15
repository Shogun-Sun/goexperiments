#!/bin/bash
set -e

ROOT_DIR=$(pwd)

# Создаём папку build, если её нет
BUILD_DIR="$ROOT_DIR/build"
mkdir -p "$BUILD_DIR"

# Определяем текущую платформу и архитектуру
PLAT=$(go env GOOS)
ARCH=$(go env GOARCH)

echo "Текущая платформа: $PLAT"
echo "Текущая архитектура: $ARCH"

# Находим все папки с main.go
PROJECTS=()
for d in */ ; do
    if [[ -f "$d/main.go" ]]; then
        PROJECTS+=("${d%/}")  # убираем слэш
    fi
done

if [ ${#PROJECTS[@]} -eq 0 ]; then
    echo "Не найдено проектов с main.go в корне."
    exit 1
fi

# Выбор проекта
echo "Выберите проект для сборки:"
select PROJ in "${PROJECTS[@]}"; do
    if [[ -n "$PROJ" ]]; then
        echo "Выбрано: $PROJ"
        break
    else
        echo "Неверный выбор. Попробуйте ещё раз."
    fi
done

PROJECT_PATH="$ROOT_DIR/$PROJ"

# Определяем расширение для Windows
EXT=""
if [[ "$PLAT" == "windows" ]]; then
    EXT=".exe"
fi

# Имя исполняемого файла в папке build
OUTPUT_FILE="$BUILD_DIR/${PROJ}_${PLAT}_${ARCH}${EXT}"

# Сборка
echo "Сборка $PROJECT_PATH для $PLAT/$ARCH..."
cd "$PROJECT_PATH"
go build -ldflags "-s -w" -o "$OUTPUT_FILE" .
cd "$ROOT_DIR"

echo "Готово! Бинарник: $OUTPUT_FILE"
