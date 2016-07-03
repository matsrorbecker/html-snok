request = require 'request'
cheerio = require 'cheerio'

module.exports = class HtmlSnok

    constructor: (@pages, @callback, options) ->
        @selector = options?.selector or 'body'
        @log = options?.log or false
        @savedPages = {}

    sniff: () =>
        for page in @pages
            @_fetchPage page

    _fetchPage: (page) ->
        options =
            url: page
            headers:
                'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'
                'Accept': 'text/html,application/xhtml+xml'

        request options, (error, response, html) =>
            if not error and response.statusCode is 200
                @_examine page, html
            else if error
                console.error error if @log
            else
                console.error "Server responded with #{response.statusCode}..." if @log

    _examine: (page, html) ->
        $ = cheerio.load html

        content = $(@selector).text()

        unless @savedPages[page]
            @savedPages[page] = content
            return

        unless content is @savedPages[page]
            @savedPages[page] = content
            @callback page, html, $