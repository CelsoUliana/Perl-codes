############################################################
### Celso A. Uliana Jr - Feb 2017
############################################################
$cont = 0;

foreach $line (<STDIN>) {
    chomp( $line );
    $_ = $line;
    if($cont != 0){
        if(m/^[hH][iI]\s[^dD]/){
            print "$line\n";
        }
    }

    $cont++;
}