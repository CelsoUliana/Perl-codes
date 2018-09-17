############################################################
### Celso A. Uliana Jr - Feb 2017
############################################################

$cont = 0;
foreach $line (<STDIN>) {

    chomp( $line );
    $_ = $line;
    if($cont > 0){
       
       @string = split("[ -]",$_);
       
       print "CountryCode=$string[0],LocalAreaCode=$string[1],Number=$string[2]\n";  
    }
    
    $cont++;
}
