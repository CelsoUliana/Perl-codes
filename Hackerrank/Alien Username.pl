############################################################
### Celso A. Uliana Jr - Feb 2017
############################################################

$cont = 0;
foreach $line (<STDIN>) {
    chomp( $line );
    $_ = $line;
    if($cont > 0){
        if(m/^[_.]{1}\d+[a-zA-Z]*_?$/){
            print "VALID\n";   
        }
        else{
            print "INVALID\n";
        }
    }

    $cont++;
}
