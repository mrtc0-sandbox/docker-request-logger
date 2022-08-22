package main

import (
	structs "github.com/fatih/structs"
	"github.com/docker/go-plugins-helpers/authorization"
	"github.com/sirupsen/logrus"
)

type AuthZPlugin struct {
	Logger *logrus.Logger
}

func (p AuthZPlugin) AuthZReq(r authorization.Request) authorization.Response {
	p.Logger.WithFields(structs.Map(r)).Info("Request received")
	return authorization.Response{Allow: true}
}

func (p AuthZPlugin) AuthZRes(r authorization.Request) authorization.Response {
	return authorization.Response{Allow: true}
}

func main() {
	logger := logrus.New()

	// f, err := os.OpenFile("/log/docker-request.log", os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0666)
	// if err != nil {
	// 	fmt.Println(err)
	// 	os.Exit(1)
	// }
	// defer f.Close()

	// logger.SetOutput(f)

	p := AuthZPlugin{Logger: logger}
	h := authorization.NewHandler(p)
	err := h.ServeUnix("request-logger", 0)
	if err != nil {
		logger.Errorf("Failed serving on socket: %v\n", err)
	}
}
