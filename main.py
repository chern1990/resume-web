from fastapi import FastAPI, Request, Response
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
import requests
import asyncio, json
from fastapi_utils.tasks import repeat_every
from fastapi.responses import FileResponse, HTMLResponse
import subprocess
import datetime, time
import os
import urllib.request
# import pdfkit
import pyppdf


app = FastAPI()
app.mount("/static", StaticFiles(directory="static"), name="static")
templates = Jinja2Templates(directory="templates")


@ app.get("/")
async def index(request: Request, contact:bool=False):
    vars = json.load(open("vars.json"))
    return templates.TemplateResponse("resume.html", context={'request':request, **vars, 'contact':contact})


@app.get("/pdf")
async def serve_pdf(request: Request):
    hostname = 'http://yeechern.ddns.net'
    filename = 'Resume'
    pdf_filepath = f'{filename}.pdf'
    vars = json.load(open("vars.json"))
    
    # options = {
    # 'page-size': 'A4',
    # 'width':,
    # 'margin-top': '0.5in',
    # 'margin-right': '0.0in',
    # 'margin-bottom': '0.5in',
    # 'margin-left': '0.0in'
    # }
    # pdf = await pdfkit.from_url('http://yeechern.ddns.net', pdf_filepath, options=options)

    pdf = await pyppdf.main(
            output_file = pdf_filepath,
            url = hostname,
            args={'pdf':{'format':'A4',
                         'printBackground':True,
                         'margin':{'top':'0.5in',
                                   'right':'0.0in',
                                   'bottom':'0.5in',
                                   'left':'0.0in'}},
                  'launch':{'args':[
                                    '--no-sandbox',                                        
                                    '--single-process',
                                    '--disable-dev-shm-usage',
                                    '--disable-gpu',
                                    '--no-zygote'
                            ]}}) 
    
    dt = datetime.datetime.now().strftime('%Y%m%d')
    try:
        pdf_file = FileResponse(path=pdf_filepath, filename=f'{vars["name"]}_{dt}.pdf')
    except:
        pdf_file = 'file not found'
    
    return pdf_file
