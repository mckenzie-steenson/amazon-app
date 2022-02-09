from typing import Optional
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import pyTigerGraph as tg
import configs as Credential

conn = tg.TigerGraphConnection(host=Credential.HOST, username=Credential.USERNAME, password=Credential.PASSWORD, graphname=Credential.GRAPHNAME)
conn.apiToken = conn.getToken(conn.createSecret())

app = FastAPI()

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get('/userExists')
def userExists(user: Optional[str] = ""):
   try:
      res = conn.runInstalledQuery("userExists", {"id": user})[0]["Res"] != []
      return {"res": res}
   except:
      return {"msg": "Uh oh! There's an error!"}

@app.get('/productExists')
def productExists(product: Optional[str] = ""):
   try:
      res = conn.runInstalledQuery("productExists", {"id": product})[0]["Res"]
      return {"res": res[0]["attributes"]}
   except:
      return {"msg": "Uh oh! There's an error!"}

@app.get('/recommender')
def recommender(user: Optional[str] = ""):
   try:
      gQuery = conn.runInstalledQuery("recommender", {"input": user})[0]["result"]
      count = 0
      children = []
      for p in gQuery:
         children.append({
            "id": str(count),
            "name": p["attributes"]["result.name"],
            "average rating": p["attributes"]["result.@avgRating"],
            "num rating": p["attributes"]["result.@numRating"]
         })
         count+=1
      result = {
         "children": children,
      }
      return result
      
   except:
      return {"msg": "Uh oh! There's an error!"}