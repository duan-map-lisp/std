package math

import (
	"fmt"

	"github.com/duan-map-lisp/dl"
)

func Add (self *dl.Dl) (res interface{}) {
	var err error
	var name string
	if len (self.SubNodeList) <= 0 {
		panic ("subNodeList len is 0")
	}

	if len (self.SubNodeList) == 1 {
		res = 0
		return
	}

	if name, err = self.SubNodeListGetSingleString (0); err != nil {
		panic (err)
	}
	if name != "+" {
		panic ("函数名异常:" + name)
	}

	tmpRes := float64 (0)
	for _, One := range self.SubNodeList {
		resI := One.Run ()

		switch resTmp := resI.(type) {
		case float64:
			tmpRes += resTmp
		case string:
			if resTmp != "+" {
				fmt.Println ("参数异常")
				panic (resTmp)
			}
		default:
			fmt.Println ("参数异常")
			panic (resTmp)
		}
	}
	res = tmpRes

	return
}
