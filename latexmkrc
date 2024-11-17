
# latexmk ja

$latex = 'platex %O %S';
$bibtex = 'pbibtex %O %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'mendex %O -o %D %S';

$pdf_mode = 3;
$pdf_update_method = 4;
$max_repeat = 4;

ensure_path("TEXINPUTS", "./deps//");
