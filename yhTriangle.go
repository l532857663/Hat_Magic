package main

import (
	"fmt"
)

func rightTriangle(n int) error {
	p := []int{1}
	for i := 0; i < n; i++ {
		str := ""
		for j := 0; j < n-i-1; j++ {
			str += " "
		}
		fmt.Printf("%s", str)
		for _, val := range p {
			fmt.Printf("%d ", val)
		}
		p = func(p []int) []int {
			q := []int{1}
			for k := 1; k < len(p); k++ {
				if k-1 < 0 {
					break
				}
				q = append(q, p[k]+p[k-1])
			}
			q = append(q, 1)
			return q

		}(p)
		fmt.Println("")
	}
	fmt.Println("")
	return nil
}

func main() {
	fmt.Println("Start")
	err := rightTriangle(10)
	if err != nil {
		fmt.Println("rightTriangle error:", err.Error())
	}
	fmt.Println("End")
}
