package main

import (
	"io"
	"os"
	"bufio"
	"log"
	"time"
	"fmt"
	"math/rand"
	"strconv"
	"flag"
	"strings"
)

var version string = "undefined"

func minimum(x, y int) (int) {
	if x < y {
		return x
	} else {
		return y
	}
}

func maximum(x, y int) (int) {
	if x > y {
		return x
	} else {
		return y
	}
}

func main() {
	display_version := flag.Bool("version", false, "Display version")

	min := flag.Int("min", 1, "The minimum possible random value")
	max := flag.Int("max", 10, "The maximum possible random value")
	flag.Parse()

	*min, *max = minimum(*min, *max), maximum(*min, *max)

	if *display_version {
		fmt.Printf("Version: %s\n", version)
		return
	}

	reader := bufio.NewReader(os.Stdin)
	s1 := rand.NewSource(time.Now().UnixNano())
	r1 := rand.New(s1)
	
	randno := r1.Intn(*max + 1 - *min) + *min

	var valid_guess bool
	var guess int = *min - 1 // in case the random number is 0

	fmt.Printf("Go on, guess a number between %d and %d.\n", *min, *max)
	for randno != guess {
		valid_guess = false
		for !valid_guess {
			fmt.Print("Enter Number: ")
			input, err := reader.ReadString('\n')
			if err != nil { 
				if err == io.EOF {
					fmt.Println("\nIf you're running this in docker, this means you need the -i flag.")
				}
				log.Fatal(err)
			}
			// Remove newline
			input = strings.TrimRight(input, "\r\n")
			guess, err = strconv.Atoi(input)
			if err != nil {
				fmt.Printf("\"%s\" isn't a number.\n", input)
			} else {
				valid_guess = true
			}
		}
		if guess > randno {
			fmt.Println("The number is lower than that")
		} else if guess < randno {
			fmt.Println("The number is higher than that.")
		}
	}
	fmt.Printf("\nCorrect!  The number is %d!\n", randno)

}