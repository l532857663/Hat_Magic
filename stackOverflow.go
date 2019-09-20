package main

import (
	"fmt"
)

func stackOverflow(i int) error {
	a := make([]string, 10)
	a[i] = "asd"
	fmt.Println("a:", a)
	return nil
}

func main() {
	fmt.Println("栈溢出操作：start")
	var count int
	fmt.Scanf("%d", &count)
	err := stackOverflow(count)
	if err != nil {
		fmt.Println("stackOverflow")
	}
	fmt.Println("栈溢出操作：end")
}
