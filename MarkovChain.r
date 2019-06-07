#!/usr/local/bin/rebol

comment { http://www.gutenberg.org/ebooks/98.txt.utf-8   51,479 free ebooks }

rebol []

comment {
	Find every word that follows the last two words in the chain 
	and append one randomly to the chain.
	Get two words from a random position in the text to begin.

	markov-words: [
		cache: [] words: terms: chain: pos: matches: match: sources: url: page: body: none
	]
	; unset first words-of markov-words

}

at-random: func [ arg ] [ at arg random length? arg ]

markov-chain: funct [
	"Generate impressively readable gibberish"
	arg
][
	random/seed now
	
	words: parse arg none

	chain: copy/part (skip at-random words -1) 2
	loop 50 [
		pos: words
		query: skip tail chain -2
		matches: collect [
			while [ pos: find/tail pos query ][ keep pos/1 ]
		]
		append chain random/only matches
	]
	return chain
]

demo-markov-chain: does [

	sources: load [
		http://www.rebol.com/docs/words/wwait.html
		http://www.gutenberg.org/cache/epub/1661/pg1661.txt ; "Sherlock Holmes" 
		http://gutenberg.net.au/ebooks01/0100021h.html
	]
	unless value? 'cache [ 
		cache: []
	]
	; "If the cache already exists then don't override it

	url: random/only sources
	page: select cache url
	unless string? page [
		print join "Reading " url
		page: read url
		if find [ %.html %.htm ] suffix? url [
			; "Get stuff between body tags then remove tags"
			body: ""
			parse page [ to "<body" start: thru "<body" copy body thru "body>" ]
			page: rejoin remove-each bit load/markup body [tag? bit] 
		]
		append cache reduce [ url page ]
	]
	print url
	duration: dt [ chain: markov-chain page ]
	print chain
	print [ "Duration:" duration ]
	

]

demo-markov-chain

