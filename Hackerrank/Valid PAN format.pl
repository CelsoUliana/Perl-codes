############################################################
### Celso A. Uliana Jr - Feb 2017
############################################################

$cont = 0;
foreach $line (<STDIN>) {
    chomp( $line );
    $_ = $line;
    if($cont != 0){
        if(m/^[A-Z]{5}[0-9]{4}[A-Z]$/){
            print "YES\n";
        }
        else{
            print "NO\n";
        }
    
    }
    $cont++;
}
