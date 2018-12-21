// +build !release,!autoupdate

package client

import (
	"github.com/traefix/ngrok2/pkg/client/mvc"
)

// no auto-updating in debug mode
func autoUpdate(state mvc.State, token string) {
}
