############################################################
### Celso A. Uliana Jr - Feb 2017
############################################################

@arr;
foreach $line (<STDIN>) {
    chomp( $line );
    $_ = $line;
        
    my @matches = $line =~ m/<a href="(.*?)".*?>(.*?)<\/a>/g;
        
    $count = scalar(@matches);
        
    if($count > 0){
        foreach $match(@matches){
            #print "$match";
            $atual = $match;
            
            $atual =~ s/^\s+|\s+$//g;
            
            #print "$teste\n";
            
            if(@aux = $match =~ m/<b>(.*)<\/b>/g){
                foreach $auxi(@aux){
                    $atual = $auxi;
                }
            }
            
            push @arr, $atual;
        }
    }
}

my $cont = 0;

foreach $res(@arr){
    if($cont == 0){
        $cont = 1;
        print "$res,";
    }
    else{
        $cont = 0;
        if($res =~ m/[<>"=;]/g){
            $res = ""
        }
        print "$res\n";
    }
}