# "search term"

Force an exact-match search. Use this to refine results for ambiguous
searches, or to exclude synonyms when searching for single words.

``` example
“steve jobs”
```

# OR

Search for X or Y. This will return results related to X or Y, or both.
Note The pipe (|) operator can also be used in place of “OR.”

``` example
jobs OR gates / jobs | gates
```

# AND

Search for X and Y. This will return only results related to both X and
Y. Note: It doesn’t really make much difference for regular searches, as
Google defaults to “AND” anyway. But it’s very useful when paired with
other operators.

``` example
jobs AND gates
```

# \-

Exclude a term or phrase. In our example, any pages returned will be
related to jobs but not Apple (the company).

``` example
jobs ‑apple
```

# \*

Acts as a wildcard and will match any word or phrase.

``` example
steve * apple
```

# ( )

Group multiple terms or search operators to control how the search is
executed.

``` example
(ipad OR iphone) apple
```

# $

Search for prices. Also works for Euro (€), but not GBP (£) 🙁

``` example
ipad $329
```

# define

A dictionary built into Google, basically. This will display the meaning
of a word in a card-like result in the SERPs.

``` example
define:entrepreneur
```

# cache

Returns the most recent cached version of a web page (providing the page
is indexed, of course).

``` example
cache:apple.com
```

# filetype

Restrict results to those of a certain filetype. E.g., PDF, DOCX, TXT,
PPT, etc. Note: The “ext:” operator can also be used—the results are
identical.

apple filetype:pdf / apple ext:pdf

# site

Limit results to those from a specific website.

``` example
site:apple.com
```

# related

Find sites related to a given domain.

``` example
related:apple.com
```

# intitle

Find pages with a certain word (or words) in the title. In our example,
any results containing the word “apple” in the title tag will be
returned.

``` example
intitle:apple
```

# allintitle

Similar to “intitle,” but only results containing all of the specified
words in the title tag will be returned.

``` example
allintitle:apple iphone
```

# inurl

Find pages with a certain word (or words) in the URL. For this example,
any results containing the word “apple” in the URL will be returned.

``` example
inurl:apple
```

# allinurl

Similar to “inurl,” but only results containing all of the specified
words in the URL will be returned.

``` example
allinurl:apple iphone
```

# intext

Find pages containing a certain word (or words) somewhere in the
content. For this example, any results containing the word “apple” in
the page content will be returned.

``` example
intext:apple
```

# allintext

Similar to “intext,” but only results containing all of the specified
words somewhere on the page will be returned.

``` example
allintext:apple iphone
```

AROUND(X)

Proximity search. Find pages containing two words or phrases within X
words of each other. For this example, the words “apple” and “iphone”
must be present in the content and no further than four words apart.

``` example
apple AROUND(4) iphone
```

# weather

Find the weather for a specific location. This is displayed in a weather
snippet, but it also returns results from other “weather” websites.

``` example
weather:san francisco
```

# stocks

See stock information (i.e., price, etc.) for a specific ticker.

``` example
stocks:aapl
```

# map

Force Google to show map results for a locational search.

``` example
map:silicon valley
```

# movie

Find information about a specific movie. Also finds movie showtimes if
the movie is currently showing near you.

``` example
movie:steve jobs
```

# in

Convert one unit to another. Works with currencies, weights,
temperatures, etc.

``` example
$329 in GBP
```

# source

Find news results from a certain source in Google News.

``` example
apple source:the_verge
```

# \_

Not exactly a search operator, but acts as a wildcard for Google
Autocomplete.

``` example
apple CEO _ jobs
```

# \#..\# <span class="tag" data-tag-name="HITMISS"><span class="smallcaps">HITMISS</span></span>

Search for a range of numbers. In the example below, searches related to
“WWDC videos” are returned for the years 2010–2014, but not for 2015 and
beyond.

``` example
wwdc video 2010..2014
```

# inanchor <span class="tag" data-tag-name="HITMISS"><span class="smallcaps">HITMISS</span></span>

Find pages that are being linked to with specific anchor text. For this
example, any results with inbound links containing either “apple” or
“iphone” in the anchor text will be returned.

``` example
inanchor:apple iphone
```

# allinanchor <span class="tag" data-tag-name="HITMISS"><span class="smallcaps">HITMISS</span></span>

Similar to “inanchor,” but only results containing all of the specified
words in the inbound anchor text will be returned.

``` example
allinanchor:apple iphone
```

# blogurl <span class="tag" data-tag-name="HITMISS"><span class="smallcaps">HITMISS</span></span>

Find blog URLs under a specific domain. This was used in Google blog
search, but I’ve found it does return some results in regular search.

``` example
blogurl:microsoft.com
```

Sidenote. Google blog search discontinued in
2011

# loc:placename <span class="tag" data-tag-name="HITMISS"><span class="smallcaps">HITMISS</span></span>

Find results from a given area.

``` example
loc:”san francisco” apple
```

Sidenote. Not officially deprecated, but results are
inconsistent.

# location <span class="tag" data-tag-name="HITMISS"><span class="smallcaps">HITMISS</span></span>

Find news from a certain location in Google News.

``` example
loc:”san francisco” apple
```

Sidenote. Not officially deprecated, but results are
inconsistent.

# \+ <span class="tag" data-tag-name="DISCONTINUED"><span class="smallcaps">DISCONTINUED</span></span>

Force an exact-match search on a single word or phrase.

``` example
jobs +apple
```

Sidenote. You can do the same thing by using double quotes around your
search.

# \~ <span class="tag" data-tag-name="DISCONTINUED"><span class="smallcaps">DISCONTINUED</span></span>

Include synonyms. Doesn’t work, because Google now includes synonyms by
default. (Hint: Use double quotes to exclude synonyms.)

``` example
~apple
```

# inpostauthor <span class="tag" data-tag-name="DISCONTINUED"><span class="smallcaps">DISCONTINUED</span></span>

Find blog posts written by a specific author. This only worked in Google
Blog search, not regular Google search.

``` example
inpostauthor:”steve jobs”
```

Sidenote. Google blog search was discontinued in
2011.

# allinpostauthor <span class="tag" data-tag-name="DISCONTINUED"><span class="smallcaps">DISCONTINUED</span></span>

Similar to “inpostauthor,” but removes the need for quotes (if you want
to search for a specific author, including surname.)

``` example
allinpostauthor:steve jobs
```

# inposttitle <span class="tag" data-tag-name="DISCONTINUED"><span class="smallcaps">DISCONTINUED</span></span>

Find blog posts with specific words in the title. No longer works, as
this operator was unique to the discontinued Google blog search.

``` example
intitle:apple iphone
```

# link <span class="tag" data-tag-name="DISCONTINUED"><span class="smallcaps">DISCONTINUED</span></span>

Find pages linking to a specific domain or URL. Google killed this
operator in 2017, but it does still show some results—they likely aren’t
particularly accurate though. (Deprecated in 2017)

``` example
link:apple.com
```

# info <span class="tag" data-tag-name="DISCONTINUED"><span class="smallcaps">DISCONTINUED</span></span>

Find information about a specific page, including the most recent cache,
similar pages, etc. (Deprecated in 2017). Note: The id: operator can
also be used—the results are identical.

Sidenote. Although the original functionality of this operator is
deprecated, it is still useful for finding the canonical, indexed
version of a URL. Thanks to @glenngabe for pointing this one one\!

``` example
info:apple.com / id:apple.com
```

# daterange <span class="tag" data-tag-name="DISCONTINUED"><span class="smallcaps">DISCONTINUED</span></span>

Find results from a certain date range. Uses the Julian date format, for
some reason.

``` example
daterange:11278–13278
```

Sidenote. Not officially deprecated, but doesn’t seem to
work.

# phonebook <span class="tag" data-tag-name="DISCONTINUED"><span class="smallcaps">DISCONTINUED</span></span>

Find someone’s phone number. (Deprecated in 2010)

``` example
phonebook:tim cook
```

# \# <span class="tag" data-tag-name="DISCONTINUED"><span class="smallcaps">DISCONTINUED</span></span>

Searches \#hashtags. Introduced for Google+; now deprecated.

``` example
#apple
```
