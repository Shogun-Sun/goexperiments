package main

import "fmt"

func main() {
	a := 20
	b := "test"
	msg := fmt.Sprintf("%s %d", b, a)
	fmt.Println(msg)
}
