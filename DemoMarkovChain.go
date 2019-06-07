// Print 50 word markov chain from a Project Gutenberg text

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

	// Read Project Gutenberg's The Adventures of Sherlock Holmes, by Arthur Conan Doyle
	bytes := ReadUrl("http://www.gutenberg.org/cache/epub/1661/pg1661.txt") 
	
	fmt.Println(MarkovChain(bytes))
	
}

func MarkovChain( arg []byte) []string {

	words := strings.Fields(string(arg))
		
	// create chain and fill it with two words from a random location
	rand.Seed(time.Now().Unix())
	chain := []string{}
	pos := rand.Intn(len(words)-2)
	chain = append(chain, words[pos])
	chain = append(chain, words[pos+1])
			
			
	for i:=1; i<=50; i+=1 { // 50 words long
	
		query := chain [ len(chain)-2: ] // match the last two words in the chain
		matches := []string{}	
		
		for i,_ := range words {
			if words[i] == query[0] && words[i+1] == query[1] {
				matches = append(matches, words[i+2])
			}
		}

		if len(matches) == 0 { 
			break 
		} else if len(matches) == 1 {  // rand.Intn(0) errors
			chain = append(chain, matches[0])
		} else if len(matches) > 1 {
			chain = append( chain, matches[rand.Intn(len(matches)-1)] )
		}
				
	}
	return chain
}

func ReadUrl(url string) []byte {
	fmt.Printf("Reading %v...\n", url)
	resp, _ := http.Get(url)
	defer resp.Body.Close()
	body, _ := ioutil.ReadAll(resp.Body)
	return body
}


