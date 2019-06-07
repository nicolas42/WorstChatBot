package main

import (
	"fmt"
	"io/ioutil"
	"strings"
	"math/rand"
	"time"
	"net/http"
)

func main() {

	t0 := time.Now()
	
	//	bytes := ReadUrl("http://www.gutenberg.org/cache/epub/1661/pg1661.txt")
	bytes, _ := ioutil.ReadFile("PrideAndPrejudice.txt")
	chain := MarkovChain(string(bytes), 100, 2) // ( inputString, chainLength, matchLength )
	
	duration := time.Since(t0)
	fmt.Println(chain)
	fmt.Println("Duration:", duration)
	
}

func MarkovChain( inputString string, chainLen int, matchLen int) []string {

	// MarkovChain( inputString, chainLength, matchLength )
	// Make a markov chain from an input string that's chainLen words long which grows 
	// by matching the last matchLen words in the chain ( generally 2 )

	words := strings.Fields(inputString)
		
	// create chain and fill it with two words from a random location
	rand.Seed(time.Now().Unix())
	chain := []string{}
	pos := rand.Intn(len(words)-matchLen)
	chain = append(chain, words[pos:pos+matchLen]...)			
			
	for i:=1; i<=chainLen; i+=1 {
	
		query := chain [ len(chain)-matchLen: ]
		matches := []string{}	
		
		for i,_ := range words {
			doesItMatch := true
			for j,_ := range query {
				if query[j] != words[i+j] {
					doesItMatch = false
					break
				}
			}
			if doesItMatch {
				matches = append(matches, words[i+2])
			}
		}

		if len(matches) == 0 { 
			break 
		} else if len(matches) == 1 { 
			chain = append(chain, matches[0])
		} else if len(matches) > 1 {
			chain = append( chain, matches[rand.Intn(len(matches)-1)] )
		}
				
	}
	return chain
}

func ReadUrl(url string) []byte {
//	resp, err := http.Get("http://www.gutenberg.org/cache/epub/1661/pg1661.txt")
	resp, err := http.Get(url)
	if err != nil {
		panic(err) 
	}
	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	return body
}

func MarkovChainStart( arg []byte) []string {

	words := strings.Fields(string(arg))
		
	// create chain and fill it with two words from a random location
	rand.Seed(time.Now().Unix())
	chain := []string{}
	pos := rand.Intn(len(words)-2)
	chain = append(chain, words[pos])
	chain = append(chain, words[pos+1])
			
			
	for i:=1; i<=50; i+=1 {
	
		query := chain [ len(chain)-2: ] // last two words in chain
		matches := []string{}	
		
		for i,_ := range words {
			if words[i] == query[0] && words[i+1] == query[1] {
				matches = append(matches, words[i+2])
			}
		}

		if len(matches) == 0 { 
			break 
		} else if len(matches) == 1 { 
			chain = append(chain, matches[0])
		} else if len(matches) > 1 {
			chain = append( chain, matches[rand.Intn(len(matches)-1)] )
		}
				
	}
	return chain
}
