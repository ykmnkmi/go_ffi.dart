package main

import (
	"C"
	"fmt"
	"time"
	"unsafe"

	"github.com/ykmnkmi/go_ffi.dart/dart_api_dl"
)

//export Initialize
func Initialize(api unsafe.Pointer) {
	dart_api_dl.Init(api)
}

//export StartWork
func StartWork(port int64) {
	fmt.Println("Go: Starting some asynchronous work")

	go work(port)

	fmt.Println("Go: Returning to Dart")
}

func work(port int64) {
	var counter int64

	for {
		time.Sleep(2 * time.Second)
		fmt.Println("GO: 2 seconds passed")
		counter++
		dart_api_dl.SendToPort(port, counter)
	}
}

// Unused
func main() {}
