package main

import "fmt"

func main() {
	a := 20
	b := "test"
	msg := fmt.Sprintf("%s %d", b, a)

	if a == 20 {
		fmt.Print(msg)
	} else {
	}
	fmt.Println(msg)
}
