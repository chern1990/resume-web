import pdfkit

hostname = 'http://yeechern.ddns.net'
filename = 'Resume'
pdf_filepath = f'{filename}.pdf'

options = {
'page-size': 'A4',
'margin-top': '0.5in',
'margin-right': '0.0in',
'margin-bottom': '0.5in',
'margin-left': '0.0in'
}
pdfkit.from_url('http://yeechern.ddns.net', pdf_filepath, options=options)
