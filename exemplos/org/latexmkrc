# !/usr/bin/perl

$ENV{'TEXINPUTS'}='./:../../inputs/:' . ($ENV{'TEXINPUTS'} || "");
$ENV{'BIBINPUTS'}='./:../../inputs/:' . ($ENV{'BIBINPUTS'} || "");
$ENV{'BSTINPUTS'}='./:../../inputs/:' . ($ENV{'BSTINPUTS'} || "");

# # $pdflatex = 'pdflatex --shell-escape %O %S';
# $pdflatex = 'xelatex --shell-escape %O %S';
# $pdf_mode=1;
# $postscript_mode = $dvi_mode = 0;

# Append options to xelatex command
$xelatex =~ s/^xelatex/xelatex --shell-escape -halt-on-error/;

print "xelatex is " . $xelatex;

add_cus_dep( 'svg', 'pdf', 0, 'inkscape_svg_2_pdf');
sub inkscape_svg_2_pdf {
    system ( "inkscape -D -z --file=\"$_[0].svg\" --export-pdf=\"$_[0].pdf\"" );
    return system( "sleep 10");
}
