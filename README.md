# latex-yearly-planner

PDF planner designed for e-ink devices. To get started quickly, read the configuration section
below to pick a configuration. Then, use [this github workflow](https://github.com/cwill747/latex-yearly-planner/actions/workflows/createplanner.yml).
Put in the Year and the configuration you want to use. The workflow will generate the planner.

## Configuration

The configuration for the planner is built up from a set of YAML files. The configuration
is a comma-separated list of files that are merged together to form the final configuration,
where each file overrides the previous one. The configuration files are located in the `cfg`
folder.

For example, to build a planner for the Remarkable Paper Pro, you might use this configuration:

```cfg/base.yaml,cfg/template_breadcrumb.yaml,cfg/rmpp.base.yaml,cfg/rmpp.breadcrumb.default.dailycal.yaml```

In order, this configuration includes:
1. The base configuration (`base.yml`), the building block for all configurations.
2. The `template_breadcrumb.yml` configuration, which adds breadcrumbs to the planner.
3. The `rmpp.base.yml` configuration, which adds the base configuration for the Remarkable Paper Pro.
4. The `rmpp.breadcrumb.default.dailycal.yml` configuration, which adds the default daily calendar configuration for the Remarkable Paper Pro.

My personal configurations:
1. Remarkable Paper Pro: `cfg/base.yaml,cfg/template_breadcrumb.yaml,cfg/rmpp.base.yaml,cfg/rmpp.breadcrumb.default.dailycal.yaml`
2. Remarkable 2: `cfg/base.yaml,cfg/template_breadcrumb.yaml,cfg/rm2.base.yaml,cfg/rm2.breadcrumb.default.dailycal.yaml`

## Local Development

### Install Dependencies
1. [Go Language](https://go.dev/dl/)
2. [LaTex](https://miktex.org/download) & [PDFLaTeX](https://www.latex-project.org/get/)
   1. For macs, the easiest option (but largest) is to do `brew install --cask mactex`
3. From the project directory, run the following command after updating
 'PLANNER_YEAR' below. This should generate the PDF in the 'out' directory.
<code>PLANNER_YEAR=2022 \
PASSES=1 \
CFG="cfg/base.yaml,cfg/template_breadcrumb.yaml,cfg/sn_a5x.breadcrumb.default.yaml" \
NAME="sn_a5x.breadcrumb.default" \
./single.sh</code>

4. Check the "out" directory for the 'pdf' planner. To move it to your device
, follow the manufacturer's instructions on how to load a PDF on your device.

If you encounter any problems related to '.sty' files you likely need to
 install some Latex related dependencies. Copying the error and search using
  your favorite search engine should get you on track to resolving the
   dependency issues. All the best!

# Preview examples
<img src="https://github.com/kudrykv/latex-yearly-planner/blob/main/examples/pictures/sn_a5x.planner/01_annual.png" width="419"><img src="https://github.com/kudrykv/latex-yearly-planner/blob/main/examples/pictures/sn_a5x.planner/02_quarter.png" width="419"><img src="https://github.com/kudrykv/latex-yearly-planner/blob/main/examples/pictures/sn_a5x.planner/03_month.png" width="419"><img src="https://github.com/kudrykv/latex-yearly-planner/blob/main/examples/pictures/sn_a5x.planner/04_week.png" width="419"><img src="https://github.com/kudrykv/latex-yearly-planner/blob/main/examples/pictures/sn_a5x.planner/05_day.png" width="419"><img src="https://github.com/kudrykv/latex-yearly-planner/blob/main/examples/pictures/sn_a5x.planner/06_day_notes.png" width="419"><img src="https://github.com/kudrykv/latex-yearly-planner/blob/main/examples/pictures/sn_a5x.planner/07_day_reflect.png" width="419"><img src="https://github.com/kudrykv/latex-yearly-planner/blob/main/examples/pictures/sn_a5x.planner/08_todos_index.png" width="419"><img src="https://github.com/kudrykv/latex-yearly-planner/blob/main/examples/pictures/sn_a5x.planner/09_todos_page.png" width="419"><img src="https://github.com/kudrykv/latex-yearly-planner/blob/main/examples/pictures/sn_a5x.planner/10_notes_index.png" width="419"><img src="https://github.com/kudrykv/latex-yearly-planner/blob/main/examples/pictures/sn_a5x.planner/11_notes_page.png" width="419">
