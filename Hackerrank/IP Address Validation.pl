############################################################
### Celso A. Uliana Jr - Feb 2017
############################################################

$cont = 0;
foreach $line (<STDIN>) {
    chomp( $line );
    $_ = $line;
    if($cont > 0){
        if(m/^((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.|$)){4}/){
            print "IPv4\n";   
        }
        elsif(m/^([0-9a-fA-F]{1,4}(:|$)){8}/){
            print "IPv6\n";
        }
        else{
            print "Neither\n";
        }
    }
    
    $cont++;
}