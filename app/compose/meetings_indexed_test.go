package compose

import (
	"testing"

	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func TestMeetingsIndexedUsesMeetingsIndexPages(t *testing.T) {
	cfg := config.Config{
		Year: 2027,
		Layout: config.Layout{
			Numbers: config.Numbers{
				NotesOnPage:        4,
				NotesIndexPages:    3,
				MeetingsIndexPages: 2,
			},
		},
	}

	modules, err := MeetingsIndexed(cfg, []string{"index.tpl", "meeting.tpl"})
	if err != nil {
		t.Fatalf("MeetingsIndexed() error = %v", err)
	}

	const want = 10 // Two index pages and eight meeting pages.
	if got := len(modules); got != want {
		t.Errorf("len(MeetingsIndexed()) = %d, want %d", got, want)
	}
}
