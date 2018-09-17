############################################################
### Celso A. Uliana Jr - Feb 2017
############################################################

$cont = 0;
foreach $line (<STDIN>) {
    chomp( $line );
    $_ = $line;
    if($cont > 0){
        if(m/^hackerrank$/){
            print "0\n";
        }
        elsif(m/^hackerrank/){
            print "1\n";
        }
        elsif(m/hackerrank$/){
            print "2\n";
        }
        else{
            print "-1\n";
        }
    }
    
    $cont++;
}