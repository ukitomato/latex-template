LaTeX template
====

This is a LaTeX template using Package iplab.sty.

## Environment
- Compiler: [upLaTeX](https://texwiki.texjp.org/?upTeX%2CupLaTeX), (pLaTex)
- PDF converter: dvipdfmx
- Automator: [latexmk](https://texwiki.texjp.org/?Latexmk)
- CI: Publish PDF to Release Pages by Github Actions

## Compile
```
$ latexmk paper.tex
```
or
```
$ uplatex paper.tex
$ ubibtex paper.tex
$ uplatex paper.tex
$ uplatex paper.tex
$ dvipdfmx paper
```
## Get Started with Github Actions
- Set your tex file info in ```.github/actions/latex/entrypoint.sh```
  - dirpath="[your tex file directory]"
  - texfilename="[your tex file name (don't write the file extention[.pdf])]"
- Push tag v```x.x.x```
  ```git tag v1.0.0 && git push```
- Auto start to compile your tex file.
- After compiling, the PDF file is published in Release Page.

## Get Started with ```iplab.sty```
### Installation
```
% \usepackage[draft]{iplab}                       % TODO, CHECK, FIXME表示
% \usepackage[draft,annot]{iplab}                 % TODO, CHECK, FIXME表示（注釈有）
% \usepackage[japanese]{iplab}                    % 日本語表示
% \usepackage[english]{iplab}                     % Draft English表示
\usepackage[draft,annot,japanese,english]{iplab}  % draft稿
% \usepackage[publish]{iplab}                     % 提出稿
```

### Usage of Package iplab.sty
#### Options
- ```draft```: 
  Enable TODO, CHECK, FIXME, FIXED commands.
- ```draft,annot```: 
  Enable TODO, CHECK, FIXME, FIXED commands showing annotations.
- ```japanese```: 
  Show Japanese (\J{...})
- ```english```: 
  Show English (\E{...})
- ```publish```: 
  Disable any commands.
#### Commands
- ```\TODO{You have to do this.}```
- ```\CHECK{You have to check this.}```
- ```\FIXME{You have to fix this.}```
- ```\FIXED{Hallo.}{Hello.}```
- ```\J{日本語...}```
- ```\E{Draft English...}```
### Examples
#### Annotation
![With Annotation](https://user-images.githubusercontent.com/20383656/75781766-29c33c00-5da1-11ea-998e-b1f61ef9cb5a.png)
#### No Annotation
![Without Annotation](https://user-images.githubusercontent.com/20383656/75782358-267c8000-5da2-11ea-8de6-3fe8993176b4.png)

## Default latexmk Setting
This setting is used automatically.
If you want to use your own settings, edit the .latexmkrc file in the same folder as the .tex file.

```
#!/usr/bin/env perl
$latex                         = 'uplatex %O -synctex=1 -halt-on-error -interaction=batchmode %S';
$pdflatex                      = 'pdflatex %O -synctex=1 -interaction=nonstopmode %S';
$lualatex                      = 'lualatex %O -synctex=1 -interaction=nonstopmode %S';
$xelatex                       = 'xelatex %O -no-pdf -synctex=1 -shell-escape -interaction=nonstopmode %S';
$biber                         = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$bibtex                        = 'upbibtex %O %B';
$makeindex                     = 'upmendex %O -o %D %S';
$dvipdf                        = 'dvipdfmx %O -o %D %S';
$dvips                         = 'dvips %O -z -f %S | convbkmk -u > %D';
$ps2pdf                        = 'ps2pdf %O %S %D';
$pdf_mode                      = 3;

$pvc_view_file_via_temporary = 0;
```

## Licence

[MIT](https://github.com/ukitomato/latex-template/blob/master/LICENSE)

## Author
Yuki Yamato [[ukitomato](https://github.com/ukitomato)]
