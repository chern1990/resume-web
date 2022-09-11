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
import pyppdf

def ping_web(host):
    print(f'Ping {host}')
    r = requests.get(f'{host}')
    print('Alive' if r.status_code else 'Dead')
    return None 


app = FastAPI()
app.mount("/static", StaticFiles(directory="static"), name="static")
templates = Jinja2Templates(directory="templates")


@ app.get("/")
async def index(request: Request, contact:bool=False):
    vars = json.load(open("vars.json"))
    return templates.TemplateResponse("resume.html", context={'request':request, **vars, 'contact':contact})


@app.get("/pdf")
async def serve_pdf(request: Request, contact:bool=False):
    urllib.request.urlretrieve("http://yeechern.ddns.net", "Resume.html")
    
    vars = json.load(open("vars.json"))
    resume_filepath = 'Resume.pdf'

    if not os.path.exists('Resume.pdf'):
        host = 'http://127.0.0.1:8000'
        # host = vars['website']
        page_url = f'{host}/?contact={contact}'
        pdf = await pyppdf.main(
            output_file=f'{resume_filepath}',
            url=page_url,
            args={'pdf':{'format':'A4',
                                'printBackground':True,
                                'margin':{'top':'0.5in',
                                            'right':'0.0in',
                                            'bottom':'0.5in',
                                            'left':'0.0in'}
                                }
                        }
            )

    dt = datetime.datetime.now().strftime('%Y%m%d')
    try:
        pdf_file = FileResponse(path=resume_filepath, filename=f'{vars["name"]}_{dt}.pdf')	
    except:
        pdf_file = 'file not found'
    return pdf_file

    
