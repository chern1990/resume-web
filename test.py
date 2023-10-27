from pyppeteer import launch
import asyncio
async def main():
    browser = await launch(executablePath='/usr/bin/google-chrome-stable', 
                           options={'devtools': True, 'headless': False}, 
                           args=['--no-sandbox'])
    page = await browser.newPage()
    await page.goto('http://google.com')
    await page.screenshot({'path': 'test.png'})
    await browser.close()

asyncio.get_event_loop().run_until_complete(main())
