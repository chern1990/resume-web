import sys
import pyppdf
import argparse

parser = argparse.ArgumentParser(description='download as pdf from url')
parser.add_argument('--url', metavar='url', type=str,
                    help='url to save as pdf',
			        default='http://127.0.0.1:8000')
args = parser.parse_args()
page_url = str(args.url) 

print(f'Save to PDF: {page_url}')
pdf = pyppdf.save_pdf(
    output_file=f'Resume.pdf',
    url=page_url,
    args_dict={'pdf':{'format':'A4',
                        'printBackground':True,
                        'margin':{'top':'0.5in',
                                    'right':'0.0in',
                                    'bottom':'0.5in',
                                    'left':'0.0in'}
                        }
                }
    )
# pdfmobile = pyppdf.save_pdf(
#    output_file=f'ResumeMobile.pdf',
#    url=page_url,
#    args_upd={'emulate':{'viewport':{'isMobile':True}},
#                'pdf':{'margin':{'top':0.2,'bottom':0.2}}
#             }
#    )
print('Save pdf done')