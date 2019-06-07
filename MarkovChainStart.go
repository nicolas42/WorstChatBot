package main

import (
	"fmt"
	"io/ioutil"
	"strings"
	"math/rand"
	"time"
)

func main() {	
	bytes, _ := ioutil.ReadFile("PrideAndPrejudice.txt")
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
