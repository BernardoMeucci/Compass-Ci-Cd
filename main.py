from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Funcionando perfeitamente aqui oh 🎆🚀🧑‍🚀!"}