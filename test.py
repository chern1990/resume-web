import pyppdf
import os
import asyncio, json

async def serve_pdf():
    hostname = 'http://yeechern.ddns.net'
    filename = 'Resume'
    pdf_filepath = f'{filename}.pdf'

    if not os.path.exists(pdf_filepath):
        print('Generate PDF')
        pdf = await pyppdf.main(
                output_file = pdf_filepath,
                url = hostname,
                # html = html_src,
                args={'pdf':{'format':'A4',
                                    'printBackground':True,
                                    'margin':{'top':'0.5in',
                                                'right':'0.0in',
                                                'bottom':'0.5in',
                                                'left':'0.0in'}
                                    },
                      'launch':{'args':[
                                        '--no-sandbox',                                        
                                        '--single-process',
                                        '--disable-dev-shm-usage',
                                        '--disable-gpu',
                                        '--no-zygote'
                                ]}
                      }
                ) 
    
