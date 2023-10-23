from pyppeteer import launch
import asyncio

async def main():
    browser = await launch(options={'devtools': True, 'headless': False})
    page = await browser.newPage()
    await page.goto('http://example.com')
    await page.screenshot({'path': 'baidu.png'})
    await browser.close()

asyncio.get_event_loop().run_until_complete(main())
