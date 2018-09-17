############################################################
### Celso A. Uliana Jr - Feb 2017
############################################################

$cont = 0;
%pdpa;
$tamanhohash = 0 ;

foreach $line (<STDIN>) {
    chomp( $line );
    $_ = $line;
    if($cont != 0){
    
        @matches = $_ =~ m/http[s]?:\/\/(ww[w2]\.)?(([a-zA-Z0-9\-]+\.)+([a-zA-Z\-])+)/g;
        $contshow = 0;
            foreach $match(@matches){
                $_ = $match;
                if(m/(([a-zA-Z0-9\-]+\.)+([a-zA-Z\-])+)/){
                    $pdpa{$1}++;
                    if($pdpa{$1} == 1){
                        $tamanhohash++;
                    }
                }
                
            }
    
    }

    $cont++;
}

$cont = 0;

foreach $key (sort keys %pdpa){
    print "$key;" if ($cont < $tamanhohash - 1);
    print "$key" if($cont == $tamanhohash -1);
    $cont++;
}
