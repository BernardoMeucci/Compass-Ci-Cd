# Usar uma imagem base oficial do Python
FROM python:3.9-slim

# Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia primeiro o arquivo de dependências
COPY requirements.txt .

# Instala as dependências a partir da lista
RUN pip install -r requirements.txt

# Copia o resto do código
COPY . .

# Expor a porta que a aplicação vai usar
EXPOSE 8000

# Comando para iniciar a aplicação quando o contêiner rodar
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]