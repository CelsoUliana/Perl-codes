############################################################
### Celso A. Uliana Jr - Feb 2017
############################################################

$cont = 0;
foreach $line (<STDIN>) {
    chomp( $line );
    $_ = $line;
    if($cont > 0){
        
        @lat = split /,/, $_;
        
        $lat[0] =~ tr/0-9.//dc;
        $lat[1] =~ tr/0-9.//dc;
        
        @chars1 = split("", $lat[0]);
        @chars2 = split("", $lat[1]);
        
        $size1 = scalar(@chars1);
        $size2 = scalar(@chars2);
        
        if(($chars1[0] ne "0" and $lat[0] <= int(90) and $chars1[$size-1] ne "." ) 
        && ($lat[1] <= int(180) and $chars2[0] ne "0" and $chars2[$size2 - 1] ne "." )){
            print "Valid\n";
        }
        else{
            print "Invalid\n";
        }
    }
    
    $cont++;
}