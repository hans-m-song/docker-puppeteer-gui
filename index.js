const puppeteer = require('puppeteer');
const fs = require('fs');

(async () => {
    const browser = await puppeteer.launch({
        headless: false, devtools: false, defaultViewport: null,
        args: [
            '--ignore-certificate-errors',
            '--disable-setuid-sandbox',
            '--disable-dev-shm-usage',
            '--disable-accelerated-2d-canvas',
            '--disable-gpu',
        ]
    });

    const page = (await browser.pages())[0];
    await page.goto('https://www.google.com');
    console.log('done');
})()