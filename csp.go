package main

import (
	"fmt"
)

// 生产者
type Produce struct {
	myChannel chan interface{}
}

func (p *Produce) send(any interface{}) {
	p.myChannel <- any
}

// 消费者
type Consumer struct {
	myChannel chan interface{}
}

func (c *Consumer) receive() {
	go func() {
		for data := range c.myChannel {
			fmt.Printf("receive:%v\n", data)
		}
	}()
}

func main() {
	var myCh = make(chan interface{})
	var consumer = &Consumer{myCh}
	consumer.receive()
	var produce = &Produce{myCh}
	for i := 1; i <= 10; i++ {
		data := fmt.Sprintf("haha%d", i)
		produce.send(data)
	}

	switch {
	}
}
