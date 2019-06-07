#!/usr/local/bin/rebol
rebol [
	title: "Draper Bot"
]

; next step - generate a whole bunch, put them on a webpage in columns and 
; have a 'hot or not' interface to select the best ones.

; from https://en.wikiquote.org/wiki/Mad_Men


comment { ; just an experiment
order-words-by-frequency: func [ 
	text-arg [string!]
	/local words unique-words word-frequencies n blk sorted just-words
] [
	words: parse text-arg none ; parse into words
	
	; Remove Punctuation from words except single quotes {'}
	forall words [ words/1: trim/with words/1 {.,?:;/!@#$%^&*()[]"} ]

	unique-words: unique words
	word-frequencies: copy []
	foreach uw unique-words [ 
		n: 0 
		parse words [ any [ thru uw ( n: n + 1 ) ] to end ]
		append word-frequencies n
	]


	blk: copy []
	repeat i length? unique-words [
		append/only blk reduce [ pick unique-words i  pick word-frequencies i ]
	]

	sorted: sort/compare blk func [ a b ] [ a/2 < b/2 ]

	just-words: copy []
	foreach a sorted [ append just-words a/1 ]

	return just-words
]

ordered: order-words-by-frequency draper-quotes
draper-words: parse draper-quotes none

print ordered
print markov-chain 50 skip draper-words 2

}

draper-quotes: {By love you mean big lightning bolts to the heart, where you can't eat and you can't work, and you just run off and get married and make babies. The reason you haven't felt it is because it doesn't exist. What you call love was invented by guys like me...to sell nylons. s
You're born alone and you die alone and this world just drops a bunch of rules on top of you to make you forget those facts, but I never forget... I'm living like there's no tomorrow, 'cause there isn't one.
Advertising is based on one thing, happiness. And you know what happiness is? Happiness is the smell of a new car. It's freedom from fear. It's a billboard on the side of the road that screams reassurance that whatever you are doing is okay. You are okay.
We should get married.
Let me ask you something, what do women want?
It wasn't a lie, it was ineptitude with insufficient cover.
Kids today, they have no one to look up to. 'Cause they're looking up to us.
I'm sure you do. Sterling Cooper has more failed artists and intellectuals than the Third Reich.
It's the way I got in.
I'm doin' my best here.
What about shaky hands, I see a lot of that with you boys?
Not all imaginary.
Maybe I'm not as comfortable being powerless as you are.
As the driven snow.
Mourning is just extended self-pity.
Well, some men like eyebrows... and all men like Joan Crawford. Salvatore couldn't stop talking about it.
I blow up bridges.
On a bed made of money.
People want to be told what to do so badly that they'll listen to anyone.
And I have a feeling that you spent more time on your hair this morning [points to Midge] than she did.
Sometimes I feel like I'm living with a child.
Neither will buying some Tokaj wine and leaning up against a wall in Grand Central pretending you're a vagrant.
Oh, my God. Stop talking and make something of yourself.
Well, I hate to break it to you, but there is no big lie. There is no system. The universe is indifferent.
[speaking to a client] Listen, I'm not here to tell you about Jesus. You already know about Jesus, either he lives in your heart or he doesn't.
I don't know. Life being lived? I'd like to stop talking about it and get back to it.
[to Pete Campbell] The day you sign a client is the day you start losing him.
You don't really believe that.
I'm going to take care of this right now.
Why? Because your parents are rich? Because you went to prep school and have a $5.00 haircut? You've been given everything. You've never worked for anything in your life.
Well, technology is a glittering lure. But there is a rare occasion when the public can be engaged on a level beyond flash ‚Äì if they have a sentimental bond with the product. My first job I was in house at a fur company, with this old pro of a copywriter, a Greek, named Teddy. Teddy told me the most important idea in advertising is 'new'. It creates an itch. You simply put your product in there as a kind of calamine lotion. He also talked about a deeper bond with a product: nostalgia. It's delicate, but potent. Sweetheart. [starts slide show featuring photos of Draper's family.] Teddy told me that in Greek, nostalgia literally means the pain from an old wound. It's a twinge in your heart, far more powerful than memory alone. This device isn't a space ship, it's a time machine. It goes backwards, forwards. It takes us to a place where we ache to go again. It's not called a wheel, it's called a carousel. It lets us travel the way a child travels. Round and a round, and back home again. To a place where we know we are loved.
Yeah. I eat a lot of apples.
[on being told to hire young people] So what am I supposed to do, dangle a Pepsi out the window and see if I can hook a stroller?
I'm gonna ask you a question that was always asked of me when I was on job interviews.
Have you ever been fired?
Says who? Just so you know, the people who talk that way think that monkeys can do this. They take all this monkey crap and stick it in a briefcase, completely unaware that their success depends on something more than shoeshine. You are the product. You feeling something. That's what sells. Not them. Not sex. They can't do what we do and they hate us for it.
The window for this apology is closing. It needs to happen before the appetizers or they will leave.
So what is this all about?
Believe me, I will ruin him. Do what I say.
[on why he won't punish his son with violence] He's a little kid. My father beat the hell out of me, and all it did was make me fantasize about the day I could murder him. And I wasn't half as good as Bobby.
What's wrong with you?
What do they want you to do?
Yes you do. Do it. Do whatever they say. [leans in and whispers] Peggy, listen to me, get out of here and move forward. This never happened. It will shock you how much it never happened.
Excuse me?
I don't know what you think happened.
It's your life. You don't know how long it's gonna last, but you know it doesn't end well. You've gotta move forward... as soon as you can figure out what that means.
You wanna be on vacation, Pete? 'Cause I can make that happen.
I have been watching my life. It's right there. I keep scratching at it, trying to get into it. I can't.
I had to have some time to think about things.
Bets, I'd do anything I could to undo what happened.
I was not respectful to you.
I can't walk away from this, I want to be with you, I want to be together again.
Find out how much it is to repair and it will come out of your allowance.
Then don't break things.
Come here. [hugs her] I'll always come home. You'll always be my girl.
[looking at a whiskey ad] Can you believe this? What is the world coming to?
That's not a bottle, that's a date.
Sorry honey, but I'm taken. I just pawned my typewriter so we can be together all weekend.
I keep going to a lot of places and ending up somewhere I've already been.
And let's also say that change is neither good or bad, it simply is. It can be greeted with terror or joy. A tantrum that says ‚'I want it the way it was,' or a dance that says ‚'Look, something new.'
You're not an artist, Peggy, you solve problems. Leave some tools in your toolbox.
No, just to this particular problem.
No one thinks you're happy. They think you're foolish.
Our worst fears lie in anticipation.
I suppose that's probably true.
This is your brother. We don't know who he is yet, or what he's gonna be. And that is a wonderful thing.
[to Peggy] Every time I turn around, you've got a hand in my pocket... there's not one thing that you've done here that I couldn't live without.
How was it?
Connie, this is my wife Betty.
Give me more ideas to reject.
Now that I can finally understand you, I am less impressed with what you have to say.
People may see things differently, but they don't really want to.
The product is good. It's high quality. Dogs love it, but the name is poisoned.
I'm not saying a new name is easy to find. And we will give you a lot of options. But it's a label on a can. And it will be true because it will promise the quality of the product that's inside.
I can explain.
Where do you want me to start?
(slowly) Donald Draper. But it used to be Dick Whitman.
People change their names, Bets. You did.
I was surprised you ever loved me.
No. Because there are people out there who buy things, people like you and me. And something happened. Something terrible. And the way that they saw themselves is gone. And nobody understands that. But you do. And that's very valuable.
With you or without you I'm moving on. And I don't know if I can do it alone. Will you help me?
No. I will spend the rest of my life trying to hire you.
I never saw myself working in a place like this.
You old men love building golden tombs and sealing the rest of us in with you.
Believe me, Henry, everyone thinks this is temporary.
Yes.
I don't hate Christmas. I hate this Christmas.
How can you stand going to the hospital every day?
We're going to the movies.
Does Howdy Doody have a wooden dick?
No there aren't.
I could tell, the minute she saw who I really was, she never wanted to look at me again. Which is why I never told her.
I had it coming.
You don't have to see a UFO to know that. But it's not a great way to think about things.
She is very important to me. I'm going to do what I have to.
[holding up a bottle] Why is this empty?
Not mine.
Chaough said he's in my rear-view mirror. Well, guess what? I'm gonna make a left turn - right off a cliff.
It's your job. I give you money, you give me ideas.
That's what the money is for! You should be thanking me every morning when you wake up, along with Jesus, for giving you another day!
My Uncle Mac said he had a suitcase that was always packed. He said a man has to be ready to go at any moment. Jesus, maybe it's a metaphor.
[about her pregnancy] Do you ever think about it?
Somebody very important to me died.
The only person in the world who really knew me.
[voice-over] People tell you who they are, but we ignore it - because we want them to be who we want them to be.
[voice-over] When a man walks into a room, he brings his whole life with him. He has a million reasons for being anywhere. Just ask him. If you listen, he'll tell you how he got there. How he forgot where he was going - then, he woke up. If you listen, he'll tell you about the time he thought he was an angel and dreamt of being perfect. And then he'll smile, with wisdom, content that he realized the world isn't perfect. We're flawed because we want so much more. We're ruined because we get these things and wish for what we had.
[to Peggy] You want some respect? Go out there and get it for yourself.
That's not a strategy, that's two strategies connected by the word and. I can do "where the pros go" or I can do "everyone's welcome," not both.
Let yourself out, lock the door behind you...as a courtesy.
I'm taking everything interesting with me.
To what? What they're saying about us is true.
I slept last night for the first time in a month.
I've got this sick feeling in the pit of my stomach.
You know it's not that simple.
And then what happens?
[about teenagers] The truth is, they're mourning for their childhood more than they're anticipating their future, because they don't know it yet, but they don't want to die.
You don't know anything about me.
We all try, we don't always make it. I've done a lot of things.
I don't know what it is about you, but I feel like myself when I'm with you, but the way I always wanted to feel, because I'm in love with you Megan, and I think I have been for a while.
When I saw you sleeping there, I thought, I couldn't imagine not seeing you there every morning. Will you marry me?
Did you ever think about the number of things that had to happen for me to get to know you? But everything happened, and it got me here. What does that mean?
[to Megan] I want you at work, because I want you.
So when you're 40, how old will I be?
It's Tuesday. I don't know.
Stan, assume that you're working.
Mohawk is going to insist on a regular copywriter.
[to Megan] I married you, and I'm gonna be with you until I die...which could be this afternoon.
Yeah, and if I had met her first I would've known not to throw it away.
I'm timing this for when we arrive. I wanna hit the doorbell with my chin.
It's none of your business.
You too.
I don't think about you at all.
Maybe you and I should go as a couple.
You scared the shit out of me.
So you think it's all him?
Because he doesn't know what he wants. But he's wanting.
You know what this woman said to me once? I like being bad, and going home and being good.
It was a disaster.
Last year at this time, whether you knew it or not, survival of this company was on the line. And I look at the faces in this room who have given their all to this tenuous recovery, and I say, prepare to take a great leap forward. Prepare to swim the English channel and then drown in champagne. There are six weekends between now and the pitch. We're going to spend them all here. We will celebrate Christmas here. We will ring in the New Year together. And in the end we will represent Jaguar and it will be worth it. Every agency on Madison Avenue is defined by the moment they got their car. When we land Jaguar, the world will know we've arrived.
But...
Really?
Well, let's pretend I'm not responsible for every single good thing that's ever happened to you. And you tell me the number. Or make one up. And I'll beat it.
Because you have a big line of diverse and charismatic products. And you keep making more. Zip-tape. Styrofoam. Rovana. And why do you do that? Because even though success is a reality, its effects are temporary. You get hungry even though you've just eaten. At the old firm, we had London Fog raincoats. We had a year where we sold 81% of the raincoats in the United States.
But we didn't stop working for them because 81% isn't enough.
Napalm was invented in 1942. The government put it in flamethrowers against the Nazis, impact bombs against the Japanese. It was all over Korea, I was there. And now it's in Vietnam. But the important thing is when our boys are fighting and they need it, when America needs it, Dow makes it and it works.
Are you? You're happy with 50%? You're on top and you don't have enough. You're happy because you're successful. For now. But what is happiness? It's a moment before you need more happiness. I won't settle for 50% of anything. I want 100%. You're happy with your agency? You're not happy with anything. You don't want most of it, you want all of it. And I won't stop until you get all of it.
Why do we do this?
[to the partners] I already said no, or should I leave so you all can do whatever you want?
[to Megan] You wanna be somebody's discovery, not somebody's wife.
[to Pete] I wish you would handle clients as well as you're handling me.
What did Dawn do?
The greatest thing you have working for you is not the photo you take or the picture you paint; it's the imagination of the consumer. They have no budget, they have no time limit, and if you can get into that space, your ad can run all day.
I never wanted to be the man who loves children, but... from the moment they're born... that baby comes out, and you act proud and excited, hand out cigars... but you don't feel anything, especially if you had a difficult childhood. You want to love them, but you don't. And the fact that you're faking that feeling makes you wonder if your father had the same problem. Then they get older, and you see them do something, and you feel that feeling that you've been pretending to have. You feel like your heart is going to explode.
It's over when I say it's over.
But I'm back.
Stop it.
It means you missed me.
It's easy to give up something when you're satisfied.
[pained] Don't...
What?
Why would you say that?
Waiting for you to tell me to stop.
That you are as beautiful as the day I met you.
You finally found a hooker who'll take traveler's checks?
Calm down.
Close the door.
Look, there's still enough money for the ad. We'll make it work.
I saved both of you. How do you think it looks?
He's not that virtuous. He's just in love with you.
I'm just looking out for the agency.
Staying out of people's business.
I'm sorry... I have to say this, because I don't know if I'll ever see you again.
I was an orphan. I grew up in Pennsylvania, in a whorehouse. I read about Milton Hershey and his school in Torn Up Magazine, or some other crap the girls left by the toilet, and I read that some orphans had a different life there. I could picture it. I dreamed of it - being wanted. Because the woman who was forced to raise me would look at me every day like she wished I would disappear. The closest I got to being wanted was with a girl who made me go through her johns' pockets while they screwed. If I collected more than a dollar, she'd buy me Hershey bar, and I would eat it alone in my room with great ceremony. [choking up] Feeling like a normal kid. It said "sweet" on the package. It was the only sweet thing in my life.
If I had my way, you would never advertise. You shouldn't have someone like me telling that boy what a Hershey bar is. He already knows.
She knows I'm a terrible husband.
Not long enough. I really thought I could do it this time.
No. She doesn't know that much, but she knows.
I keep wondering, have I broken the vessel?
I bet you could.
[pause] I'm sorry, but I have to get back to work.
I was in a pitch meeting, and I told them the truth about me. But it was the wrong time.
Nothing you don't know.
Have you calmed down?
Stop it.
LeaseTech, the company we're leasing the computer from, is a virgin. I think we should prepare a presentation while their guy is here and push 'em over the edge.
That whole industry is exploding. The sky has exponential growth.
Fine, tell somebody else. I mean, the apple is right there.
So, that's it? You want me to be a janitor? Whistle while I work?
So why am I even here? I could have gone anywhere.
Because I started this agency!
I don't wanna hear that.
I'm afraid I do.
You could let everyone go.
No. I'd let you go, Lou.
[skeptically] What's her profession?
It's too sad for an ad.
Keep going.
How did you get in here?
What do you see for the future?
No. I'm just curious.
No, I'm impressed that you know exactly.
That's what I'm asking. Let's say you get that. What's next?
So you want fame.
What else?
Yes you do.
[chuckles] In advertising.
So, you think those things are unrelated?
Do you want me to do this or not?
[to Sally] You're a very beautiful girl. It's up to you to do more than that.
How do I describe California in a way that doesn't make them jealous?
Were they difficult to move?
I must be tired.
Racine, Wisconsin.
That's not going to stop me.
Remember On the Road?
I'm riding the rails.
I messed everything up. I'm not the man you think I am.
I broke all my vows. I scandalized my child. I took another man's name and made nothing of it.
I only called because I realized I never said goodbye to you.}

markov-chain: func [
	length
	arg [block!] 
	/local chain pos matches
][
    chain: copy []
    random/seed now

    ; allows seeding at a particular initial position in the words block
    either head? arg [
    	pos: at arg (random length? arg) - 3
    ] [
    	pos: arg
    ]
    append chain copy/part pos 2

    loop length [
        pos: head arg
        matches: copy []
        while [
        	pos: find/tail pos (copy/part tail chain -2)
        ] [
        	append matches pos/1
        ]
        append chain random/only matches
    ]
    form chain
]

n: 50
if system/options/args [
	n: do system/options/args/1  ; system/options/args is a block of strings
]

print markov-chain n parse draper-quotes none

; words: func [ arg [string!] ] [ parse arg none ]

; at-random: func [ arg ] [ at arg random length? arg ]

; draper-speak: does [ print markov-chain 50 at-random words draper-quotes ]


comment {
; speak on mac
draper-speak: has [ n str ] [

	n: do system/options/args/1  ; system/options/args is a block of strings
	str: form markov-chain n parse draper-quotes none
	print str
	call rejoin [ {say "} str {"} ] 
]

draper-speak
quit
}