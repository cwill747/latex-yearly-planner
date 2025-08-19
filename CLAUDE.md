# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## About This Project

This is a LaTeX-based yearly planner generator designed for e-ink devices. It generates PDF planners with customizable layouts for different devices like reMarkable tablets, Supernote devices, and others. The codebase is written in Go and generates LaTeX templates that are compiled into PDFs.

## Build Commands

### Quick Build (Using GitHub Actions)
Use the [GitHub workflow](https://github.com/cwill747/latex-yearly-planner/actions/workflows/createplanner.yml) with year and configuration parameters.

### Local Development Commands

**Build a planner:**
```bash
PLANNER_YEAR=2025 PASSES=1 CFG="cfg/base.yaml,cfg/template_breadcrumb.yaml,cfg/rmpp.base.yaml,cfg/rmpp.breadcrumb.default.dailycal.yaml" NAME="rmpp.breadcrumb" ./single.sh
```

**Quick build with default config:**
```bash
./build.sh 2025
```

**Device-specific shortcuts:**
- reMarkable 2: `./rm2.sh`  
- reMarkable Paper Pro: `./rmpp.sh`

**Run tests:**
```bash
go test ./app/components/cal/
```

**Build the Go binary:**
```bash
go build -o plannergen cmd/plannergen/plannergen.go
```

## Dependencies

1. **Go 1.16+** - Core application language
2. **LaTeX & XeLaTeX** - For PDF generation (install via `brew install --cask mactex` on macOS)
3. **Python 3** - For translation support

## Configuration System

The configuration is built from layered YAML files in the `cfg/` directory:

1. **base.yaml** - Core settings (paper size, margins, layout numbers)
2. **Template files** - Layout patterns (`template_breadcrumb.yaml`, `template_months_on_side.yaml`)
3. **Device-specific** - Device dimensions and optimizations (`rmpp.base.yaml`, `rm2.base.yaml`)
4. **Feature variants** - Additional features (`*.dailycal.yaml` for daily calendars)

**Example configurations:**
- reMarkable Paper Pro: `cfg/base.yaml,cfg/template_breadcrumb.yaml,cfg/rmpp.base.yaml,cfg/rmpp.breadcrumb.default.dailycal.yaml`
- reMarkable 2: `cfg/base.yaml,cfg/template_breadcrumb.yaml,cfg/rm2.base.yaml,cfg/rm2.breadcrumb.default.dailycal.yaml`

## Architecture Overview

### Core Components

**Main Application (`cmd/plannergen/plannergen.go`)**
- CLI entry point using urfave/cli
- Handles configuration parsing and template generation

**App Layer (`app/app.go`)**
- Orchestrates the planner generation process
- Maps render functions to template composers
- Manages preview mode and file output

**Configuration (`app/config/config.go`)**
- Layered YAML configuration parsing with environment variable support
- Defines paper dimensions, margins, layout numbers, and rendering options
- Key environment variables: `PLANNER_YEAR`, `PLANNER_LAYOUT_PAPER_*`

**Calendar Components (`app/components/cal/`)**
- `year.go`, `quarter.go`, `month.go`, `week.go`, `day.go` - Core calendar data structures
- Handles date calculations, layout positioning, and calendar hierarchy

**Composers (`app/compose/`)**
- Functions that generate page modules for different planner sections:
  - `Annual`, `Quarterly`, `Monthly`, `Weekly` - Time-based layouts
  - `Daily`, `DailyReflect`, `DailyNotes` - Day-specific pages
  - `NotesIndexed`, `MeetingsIndexed` - Index and content pages

**Templates (`tpls/` and `app/tpls/`)**
- LaTeX template files with Go template syntax
- `document.tpl` - Main LaTeX document structure
- Section-specific templates (`_common_*.tpl`, `breadcrumb_*.tpl`, `mos_*.tpl`)

### Key Data Flow

1. Configuration files are merged in order (later configs override earlier ones)
2. The Go application generates LaTeX `.tex` files in the `out/` directory
3. Optional translation is applied via Python script
4. XeLaTeX compiles the `.tex` files into final PDF
5. Multiple passes ensure proper LaTeX cross-references and layout

### Translation Support

The `translate.py` script modifies generated LaTeX files to replace English text with translations from `translations/*.json` files. Supported languages include Brazilian Portuguese, Czech, German, Spanish, and Turkish.

## File Structure

- `cfg/` - Configuration files for different devices and layouts
- `tpls/` - LaTeX template files  
- `out/` - Generated LaTeX and PDF output files
- `app/components/` - Go calendar and layout logic
- `app/compose/` - Template composition functions
- `translations/` - Language files for internationalization
- `examples/pictures/` - Sample planner page images