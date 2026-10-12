# Beyond Pure Transformers — seminar report

B.Tech seminar report (KTU format) on hybrid Mamba-Transformer architectures in
NVIDIA's Nemotron 3 Super ([arXiv:2604.12374](https://arxiv.org/abs/2604.12374)).

## Layout

```
report/
  main.tex            root file; student, guide and department names are macros at the top
  chapters/           front matter (00-*) and chapters 1-10
  figures/            figures taken from the cited papers (file name = paper + figure number)
  figures/tikz/       diagrams drawn for this report
  refs.bib            references (IEEE style, IEEEtran.bst)
scripts/fetch_figures.sh   re-downloads the arXiv sources into refs/ and copies the figures
```

## Build

```
cd report
latexmk -pdf main.tex
```

Every push that touches `report/` is also compiled by GitHub Actions
(`.github/workflows/build.yml`); the PDF is attached to the run as the
`seminar-report` artifact.

## Before printing

Fill in the placeholder names near the top of `report/main.tex`
(`\guidename`, `\coordinatorname`, `\hodname`, `\principalname` and their
designations) and check `\department`.

## Figures

Figures reproduced from published papers keep their source in the caption
("Source: ..., Fig. N") and belong to their respective authors. Figures marked
"drawn by the author" are TikZ diagrams in `report/figures/tikz/`.
