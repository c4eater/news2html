Introduction
============

This is my collection of XSLT templates for transforming the articles (with comments) from certain websites into a bare HTML form suitable for offline viewing in a text-only HTML browser, such as **lynx**, **w3m** or some old e-readers.

These templates preserve only the &lt;div&gt; blocks containing the title, article and comments. All the other content is stripped off, including:

  - controls (eg. reply buttons)
  - &lt;script&gt; and &lt;noscript&gt;
  - ad blocks
  - social buttons
  - CSS

Thus, the resulting HTML generally looks as:
```html
<html>

  <head>
    <title>Article Name</title>
  </head>

  <body>
    <div class="article">
      Article Text
    </div>

    <div class="comments">
      Comment 1
         Comment 2
             Comment 3
      Comment 4
    </div>
  </body>
</html>
```


As every site has its own HTML layout, there is no way to have a universal XSLT template.
So, normally I provide 1 XSLT template per website.
Currently supported websites include:

  - Slashdot
  - habrahabr.ru and geektimes.ru (Russian technology related blog platforms owned by the same company, TechMedia, and using the same engine)




Invoking the tool
=================

## 1.
First of all, you need the actual HTML content. Simple **curl** or **wget** aren't going to work as most of the site's content is dynamically generated by Javascript. The most straightforward solution is to open the webpage in any modern browser, make it display all content (eg. move the "show all" slider in Slashdot), hit the "view source" button, and copy-n-paste the HTML into a file.
In theory, this can be automated by simulating the user's actions via JS, but I'm by no means a web developer, and hardly know how to procedurally interact with the page's JS.


## 2.
Like any other XSLT templates, these templates require an XML input, while the original content is coming in HTML form. Thus, you need to convert HTML to XHTML first, using tool like e.g. HTML Tidy:

    tidy5 -q -asxhtml -bare -o article.xml article.html

I do not provide a box solution deliberately. This approach allows me to strip down this repository's contents to a bare set of XSLT templates, and lets the users build their own toolchain.


## 3.
Now you can actually invoke the template:

    xsltproc template_name.xsl article.xml > output.html



Usage scenario and alternatives
===============================

I use these templates for reading articles on my old e-reader, Pocketbook 301.
Instead of using XSLT, you may consider some alternative approaches to offline viewing:


## 1. Atom/RSS.


- Advantages:
  - Works out of the box, supported by nearly every device.


- Disadvantages:
  - Getting slowly driven out by the modern ad-driven and JS-driven Web approach.
  - Old articles expire (and storing them is the matter of the client's grace; most clients don't care).
  - Not all websites produce the feed.
  - Often, instead of the full article, the site exposes only an article header or an incomplete article.
  - Comments are usually not included.
  - Not relocatable (the only common way to retrieve the RSS is the endpoint RSS client, which is usually able only to fetch & read the article, and rarely has an ability to store and resend the contents elsewhere).



## 2. Just download the full HTML content and view it offline.


- Advantages:
  - Works out of the box, needs minimal effort.


- Disadvantages:
  - Has a lot of garbage content (JS, ad blocks, control buttons) which is especially bad for the text-mode view.
  - Not all browsers support the latest HTML standard.
  - Content is scattered over multiple files (html, css, images, etc), hard to operate/relocate.
  - Offline view does not guarantee to produce the same result as in online mode.



## 3. Copy & paste the text browser's output.


- Advantages:
  - Works out of the box, supported by nearly every device.
  - Plain text content is very portable.


- Disadvantages:
  - Garbage content is still not stripped completely.
  - Fixed width (kills e-reader viewing right away).
