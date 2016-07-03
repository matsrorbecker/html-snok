html-snok
===========

###A little tool for detecting changes on web pages.

Installation
------------

First you need to install [Node.js](https://nodejs.org/). After that, run the following command:

    npm install matsrorbecker/html-snok

Usage
-----
Example:

```javascript
const HtmlSnok = require('html-snok');

const pagesToCheck = [
	'http://www.dn.se/'
]

const notify = function (link) {
	console.log("Hey, this page has been updated:");
	console.log(link);
}

const secondsBetweenChecks = 60;

const options = {
	selector: '.article-teaser-list'	
}

const htmlSnok = new HtmlSnok(pagesToCheck, notify, options);

setInterval(htmlSnok.sniff, secondsBetweenChecks * 1000);
htmlSnok.sniff();
```

Besides the link, the HTML and a [cheerio](https://github.com/cheeriojs/cheerio) object is passed to the callback.

License
-------

This little piece of software is licensed under the terms of the [ISC License](http://en.wikipedia.org/wiki/ISC_license).
