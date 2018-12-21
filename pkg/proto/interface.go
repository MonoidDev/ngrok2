package proto

import (
	"github.com/traefix/ngrok2/pkg/conn"
)

type Protocol interface {
	GetName() string
	WrapConn(conn.Conn, interface{}) conn.Conn
}
