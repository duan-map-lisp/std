package main

import (
	"github.com/duan-map-lisp/dl"
	"github.com/duan-map-lisp/std/math"
)

func Load (self *dl.Dl) {
	dl.Lambdas["+"] = math.Add

	return
}
