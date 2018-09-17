############################################################
### Celso A. Uliana Jr - Feb 2017
############################################################

$cont = 0;
foreach $line (<STDIN>) {
    chomp( $line );
    $_ = $line;
    if($cont > 0){
        if(m/^[a-z]{0,3}[0-9]{2,8}[A-Z]{3,}$/){
            print "VALID\n";
        }
        else{
            print "INVALID\n";
        }
    
    }

    $cont++;
}